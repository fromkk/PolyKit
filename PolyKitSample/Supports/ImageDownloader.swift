//
//  ImageDownloader.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    typealias Success = (UIImage) -> ()
    typealias Failure = (Error) -> ()
    
    func download(with url: URL, success: @escaping Success, failure: @escaping Failure) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                failure(error)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            success(image)
        }
        task.resume()
    }
    
}
