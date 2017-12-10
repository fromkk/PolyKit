//
//  PolyAsset+Download.swift
//  PolyKit
//
//  Created by Kazuya Ueoka on 2017/12/09.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public extension PolyAsset {
    
    public typealias Result = (PolyResults <URL>) -> ()
    
    public func downloadObj(_ result: @escaping Result) {
        let downloader = PolyAssetDownloader(asset: self, format: Poly3DFormat.obj) { (downloaderResult) in
            DispatchQueue.main.async {
                result(downloaderResult)
            }
        }
        downloader.run()
    }
    
    class PolyAssetDownloader: NSObject, URLSessionDownloadDelegate {
        
        var downloadedUrls: [URL] = []
        
        let asset: PolyAsset
        let result: Result
        let format: Poly3DFormat
        init(asset: PolyAsset, format: Poly3DFormat, result: @escaping PolyAsset.Result) {
            self.asset = asset
            self.format = format
            self.result = result
            
            super.init()
        }
        
        func run() {
            guard !stopDownloadIfExists() else {
                return
            }
            
            do {
                try createDirectoryIfNeeded()
            } catch {
                result(PolyResults.failure(error))
                return
            }
            
            downloadURLs.forEach { (url) in
                self.download(with: url)
            }
        }
        
        /// Current format
        private var currentFormat: PolyFormat? {
            return asset.formats?.filter({ (current) -> Bool in
                current.formatType == self.format.rawValue
            }).first
        }
        
        /// Local directory URL
        private var directoryURL: URL {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            return URL(fileURLWithPath: path).appendingPathComponent(String(format: "me.fromkk.PolyKit/%@", asset.name))
        }
        
        /// URLs for download
        private var downloadURLs: [URL] {
            var result: [URL] = []
            
            if let root = currentFormat?.root?.url, let url = URL(string: root) {
                result.append(url)
            }
            
            if let resources = currentFormat?.resources {
                result += resources.flatMap({ (file) -> URL? in
                    guard let url = file.url else { return nil }
                    return URL(string: url)
                })
            }
            
            return result
        }
        
        /// Stop download if local file exists
        ///
        /// - Returns: Bool file exists
        private func stopDownloadIfExists() -> Bool {
            guard let format = currentFormat else { return false }
            
            guard let urlString = format.root?.url, let url = URL(string: urlString) else { return false }
            
            let localUrl = directoryURL.appendingPathComponent(url.lastPathComponent)
            
            let fileManager = FileManager.default
            let fileExists = fileManager.fileExists(atPath: localUrl.path)
            
            if fileExists {
                result(PolyResults.success(localUrl))
            }
            
            return fileExists
        }
        
        /// Create local directory if needed
        ///
        /// - Throws: Error
        private func createDirectoryIfNeeded() throws {
            let url = directoryURL
            
            let fileManager = FileManager.default
            guard !fileManager.fileExists(atPath: url.path) else {
                return
            }
            
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        /// Start download with URL
        ///
        /// - Parameter url: URL
        private func download(with url: URL) {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
            let task = session.downloadTask(with: url)
            task.resume()
        }
        
        public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            guard let originalURL = downloadTask.originalRequest?.url else { return }
            
            let fileName = originalURL.lastPathComponent
            let localUrl = directoryURL.appendingPathComponent(fileName)
            
            let fileManager = FileManager.default
            do {
                try fileManager.moveItem(at: location, to: localUrl)
            } catch {
                result(PolyResults.failure(error))
            }
            
            downloadedUrls.append(localUrl)
            
            handleDownloadedUrls()
        }
        
        private func handleDownloadedUrls() {
            guard downloadURLs.count == downloadedUrls.count, let format = currentFormat else { return }
            
            guard let rootUrl = downloadedUrls.filter({ (url) -> Bool in
                return url.pathExtension.lowercased() == format.formatType?.lowercased()
            }).first else {
                return
            }
            
            result(PolyResults.success(rootUrl))
        }
        
    }
    
}
