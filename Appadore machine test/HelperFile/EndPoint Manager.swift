//
//  EndPoint Manager.swift
//  Appadore machine test
//
//  Created by Apple on 07/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import Foundation
public func devUrl()->String {
    let baseUrl = "http://huddle-dev.messej.com/huddles/"
    let rout = "podium_dummy"
    return "\(baseUrl)\(rout)"
}
