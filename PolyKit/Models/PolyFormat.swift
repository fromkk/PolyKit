//
//  PolyFormat.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyFormat: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case root
        case resources
        case formatComplexity
        case formatType
    }
    
    public let root: PolyFile?
    
    public let resources: [PolyFile]?
    
    public let formatComplexity: PolyFormatComplexity?
    
    public let formatType: String?
    
}
