//
//  PolyAssetsQuery.swift
//  PolyKit
//
//  Created by Kazuya Ueoka on 2017/12/09.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyAssetsQuery: URLQueryResponsable {
    
    public enum Complexity: String {
        case complexityUnspecified = "COMPLEXITY_UNSPECIFIED"
        case complex = "COMPLEX"
        case medium = "MEDIUM"
        case simple = "SIMPLE"
    }
    
    public init(keywords: String? = nil, curated: Bool? = nil, category: String? = nil, maxComplexity: Complexity? = nil, format: Poly3DFormat? = nil, pageSize: Int? = nil, orderBy: String? = nil, pageToken: String? = nil) {
        self.keywords = keywords
        self.curated = curated
        self.category = category
        self.maxComplexity = maxComplexity
        self.format = format
        self.pageSize = pageSize
        self.orderBy = orderBy
        self.pageToken = pageToken
    }
    
    public var keywords: String? = nil
    
    public var curated: Bool? = nil
    
    public var category: String? = nil
    
    public var maxComplexity: Complexity? = nil
    
    public var format: Poly3DFormat? = nil
    
    public var pageSize: Int? = nil
    
    public var orderBy: String? = nil
    
    public var pageToken: String? = nil
    
    func urlQueries() -> [URLQueryItem] {
        var queries: [String: String] = [:]
        if let keywords = keywords {
            queries["keywords"] = keywords
        }
        
        if let curated = curated {
            queries["curated"] = curated ? "true" : "false"
        }
        
        if let category = category {
            queries["category"] = category
        }
        
        if let maxComplexity = maxComplexity {
            queries["maxComplexity"] = maxComplexity.rawValue
        }
        
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
