//
//  PolyListResponse.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyListResponse: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case assets
        case nextPageToken
        case totalSize
    }
    
    public let assets: [PolyAsset]?
    
    public let nextPageToken: String?
    
    public let totalSize: Int?
    
}
