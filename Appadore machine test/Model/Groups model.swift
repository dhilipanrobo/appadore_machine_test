//
//  Groups model.swift
//  Appadore machine test
//
//  Created by Apple on 07/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import Foundation
struct Groups_Base : Codable,Hashable {
    let message : String?
    let result : Result?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case result = "result"
    }
}
struct Groups : Codable,Hashable {
    let bio : String?
    let group_photo : String?
    let id : Int?
    let name : String?
    let participant_count : Int?
    let mprivate : Bool?
    let unread_count : Int?
    let user_status : String?

    enum CodingKeys: String, CodingKey {

        case bio = "bio"
        case group_photo = "group_photo"
        case id = "id"
        case name = "name"
        case participant_count = "participant_count"
        case mprivate = "private"
        case unread_count = "unread_count"
        case user_status = "user_status"
    }
}

struct Result : Codable,Hashable {
    let current_page : Int?
    let groups : [Groups]?
    let next_page : Bool?
    let total : Int?

    enum CodingKeys: String, CodingKey {

        case current_page = "current_page"
        case groups = "groups"
        case next_page = "next_page"
        case total = "total"
    }
}
