//
//  PolyQuaternion.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyQuaternion: Codable {
    private enum CodingKeys: String, CodingKey {
        case x
        case y
        case z
        case w
    }
    
    public let x: Double?
    
    public let y: Double?
    
    public let z: Double?
    
    public let w: Double?
    
}
