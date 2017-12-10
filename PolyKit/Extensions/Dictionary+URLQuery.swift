//
//  Dictionary+URLQuery.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    
    var urlQueries: [URLQueryItem] {
        return map { (element) -> URLQueryItem in
            return URLQueryItem(name: element.key, value: element.value)
        }
    }
    
}
