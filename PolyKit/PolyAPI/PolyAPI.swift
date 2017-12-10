//
//  PolyAPI.swift
//  PolyKit
//
//  Created by Kazuya Ueoka on 2017/12/09.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public class PolyAPI {
    
    public enum PolyError: Error {
        case createURLFailed
        case noData
        case notFound
        case responseError
    }
    
    var apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public typealias AssetResponse = (PolyResults <PolyAsset>) -> ()
    
    public typealias ListResponse = (PolyResults <PolyListResponse>) -> ()
    
    public typealias UserAssetsResponse = (PolyResults <PolyUserAssetsResponse>) -> ()
    
    /// Get asset from Poly API
    ///
    /// - Parameters:
    ///   - assetId: String
    ///   - result: AssetResponse
    public func asset(_ assetId: String, result: @escaping AssetResponse) {
        let assetUrl = URL(string: String(format: "%@/v1/assets/%@", PolyConstants.domain, assetId))!
        var components = URLComponents(url: assetUrl, resolvingAgainstBaseURL: false)!
        components.queryItems = _commonQueryItems(apiKey)
        
        guard let url = components.url else {
            result(PolyResults.failure(PolyError.createURLFailed))
            return
        }
        
        _download(url: url) { (data, error) in
            DispatchQueue.main.async {
                do {
                    let asset: PolyAsset = try self._convert(with: data, and: error)
                    result(PolyResults.success(asset))
                } catch {
                    result(PolyResults.failure(error))
                }
            }
        }
    }
    
    /// Get assets from Poly API
    ///
    /// - Parameters:
    ///   - query: PolyAssetsQuery
    ///   - result: ListResponse
    public func assets(with query: PolyAssetsQuery?, result: @escaping ListResponse) {
        let assetsUrl = URL(string: String(format: "%@/v1/assets", PolyConstants.domain))!
        var components = URLComponents(url: assetsUrl, resolvingAgainstBaseURL: false)!
        let queries: [URLQueryItem] = query?.urlQueries() ?? []
        components.queryItems = queries + _commonQueryItems(apiKey)
        
        guard let url = components.url else {
            result(PolyResults.failure(PolyError.createURLFailed))
            return
        }
        
        _download(url: url) { (data, error) in
            DispatchQueue.main.async {
                do {
                    let assets: PolyListResponse = try self._convert(with: data, and: error)
                    result(PolyResults.success(assets))
                } catch {
                    result(PolyResults.failure(error))
                }
            }
        }
    }
    
    /// Get user assets from Poly API
    ///
    /// - Parameters:
    ///   - userId: String
    ///   - query: PolyUsersAssetsQuery
    ///   - result: UserAssetsResponse
    public func usersAssets(with userId: String, and query: PolyUsersAssetsQuery?, result: @escaping UserAssetsResponse) {
        let assetsUrl = URL(string: String(format: "%@/v1/users/%@/assets", PolyConstants.domain, userId))!
        var components = URLComponents(url: assetsUrl, resolvingAgainstBaseURL: false)!
        let queries: [URLQueryItem] = query?.urlQueries() ?? []
        components.queryItems = queries + _commonQueryItems(apiKey)
        
        guard let url = components.url else {
            result(PolyResults.failure(PolyError.createURLFailed))
            return
        }
        
        _download(url: url) { (data, error) in
            DispatchQueue.main.async {
                do {
                    let userAssets: PolyUserAssetsResponse = try self._convert(with: data, and: error)
                    result(PolyResults.success(userAssets))
                } catch {
                    result(PolyResults.failure(error))
                }
            }
        }
    }
    
    /// Get user liked assets from Poly API
    ///
    /// - Parameters:
    ///   - userId: String
    ///   - query: PolyUsersLikedassetsQuery
    ///   - result: ListResponse
    public func usersLikedAssets(with userId: String, and query: PolyUsersLikedAssetsQuery?, result: @escaping ListResponse) {
        let likedUrl = URL(string: String(format: "%@/v1/users/%@/likedassets", PolyConstants.domain, userId))!
        var components = URLComponents(url: likedUrl, resolvingAgainstBaseURL: false)!
        let queries: [URLQueryItem] = query?.urlQueries() ?? []
        components.queryItems = queries + _commonQueryItems(apiKey)
        
        guard let url = components.url else {
            result(PolyResults.failure(PolyError.createURLFailed))
            return
        }
        
        _download(url: url) { (data, error) in
            DispatchQueue.main.async {
                do {
                    let assets: PolyListResponse = try self._convert(with: data, and: error)
                    result(PolyResults.success(assets))
                } catch {
                    result(PolyResults.failure(error))
                }
            }
        }
    }
    
    private func _download(url: URL, result: @escaping (Data?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                result(nil, error)
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                result(data, nil)
            case 404:
                result(nil, PolyError.notFound)
            default:
                result(nil, PolyError.responseError)
            }
        }
        task.resume()
    }
    
    private func _convert <T: Codable>(with data: Data?, and error: Error?) throws -> T {
        if let error = error {
            throw error
        }
        
        guard let data = data else {
            throw PolyError.noData
        }
        
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    func _commonQueryItems(_ apiToken: String) -> [URLQueryItem] {
        return [URLQueryItem(name: "key", value: apiToken)]
    }
    
}
