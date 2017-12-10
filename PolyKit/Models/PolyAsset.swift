//
//  PolyAsset.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyAsset: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case displayName
        case authorName
        case description
        case createTime
        case updateTime
        case formats
        case thumbnail
        case license
        case visibility
        case isCurated
        case presentationParams
    }
    
    public let name: String
    
    public let displayName: String?
    
    public let authorName: String?
    
    public let description: String?
    
    public let createTime: String?
    
    public let updateTime: String?
    
    public let formats: [PolyFormat]?
    
    public let thumbnail: PolyFile?
    
    public let license: String?
    
    public let visibility: String?
    
    public let isCurated: Bool?
    
    public let presentationParams: PolyPresentationParams?
    
}
