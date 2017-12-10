//
//  BinaryFloatingPoint+Extension.swift
//  PolyAPI
//
//  Created by Kazuya Ueoka on 2017/12/10.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

extension BinaryFloatingPoint {
    var toRadians: Self { return self * .pi / 180.0 }
    var toDegrees: Self { return self * 180.0 / .pi }
}
