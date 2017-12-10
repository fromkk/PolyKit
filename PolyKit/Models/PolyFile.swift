//
//  PolyFile.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyFile: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case relativePath
        case url
        case contentType
    }
    
    public let relativePath: String?
    
    public let url: String?
    
    public let contentType: String?
    
}
