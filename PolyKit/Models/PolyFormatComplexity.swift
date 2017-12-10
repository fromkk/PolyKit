//
//  PolyFormatComplexity.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyFormatComplexity: Codable {
    private enum CodingKeys: String, CodingKey {
        case triangleCount
        case lodHint
    }
    
    public let triangleCount: String?
    
    public let lodHint: UInt?
}
