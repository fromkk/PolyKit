//
//  PolyPresentationParams.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/08.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public struct PolyPresentationParams: Codable {
    private enum CodingKeys: String, CodingKey {
        case orientingRotation
        case colorSpace
    }
    
    public let orientingRotation: PolyQuaternion?
    
    public let colorSpace: String?
}
