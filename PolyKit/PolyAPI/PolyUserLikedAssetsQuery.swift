//
//  PolyUserLikedAssetsQuery.swift
//  PolyKit
//
//  Created by Kazuya Ueoka on 2017/12/09.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyUsersLikedAssetsQuery: URLQueryResponsable {
    
    public var format: Poly3DFormat? = nil
    
    public var pageSize: Int? = nil
    
    public var orderBy: String? = nil
    
    public var pageToken: String? = nil
    
    public init(format: Poly3DFormat? = nil, pageSize: Int? = nil, orderBy: String? = nil, pageToken: String? = nil) {
        self.format = format
        self.pageSize = pageSize
        self.orderBy = orderBy
        self.pageToken = pageToken
    }
    
    func urlQueries() -> [URLQueryItem] {
        var queries: [String: String] = [:]
        
        if let format = format {
            queries["format"] = format.rawValue
        }
        
        if let pageSize = pageSize {
            queries["pageSize"] = String(pageSize)
        }
        
        if let orderBy = orderBy {
            queries["orderBy"] = orderBy
        }
        
        if let pageToken = pageToken {
            queries["pageToken"] = pageToken
        }
        
        return queries.urlQueries
    }
    
}
