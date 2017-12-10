//
//  PolyResults.swift
//  PolyKit
//
//  Created by Kazuya Ueoka on 2017/12/09.
//  Copyright © 2017 fromkk. All rights reserved.
//

import Foundation

public enum PolyResults <T> {
    case success(T)
    case failure(Error)
}
