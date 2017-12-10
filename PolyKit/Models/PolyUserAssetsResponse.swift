//
//  PolyUserAssetsResponse.swift
//  PolyKit
//
//  Created by Kazuya Ueoka on 2017/12/09.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyUserAssetsResponse: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case uesrAssets
        case nextPageToken
        case totalSize
    }
    
    public let uesrAssets: [PolyAsset]?
    
    public let nextPageToken: String?
    
    public let totalSize: Int?
    
}
