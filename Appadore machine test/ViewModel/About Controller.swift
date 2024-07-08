//
//  AboutController.swift
//  Appadore machine test
//
//  Created by Apple on 08/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import Foundation

class AboutController: ObservableObject {
    let coreDataManager = CoreDataManager()
    
    @Published var bio = ""
    @Published var unread_count = 0
    @Published var name = ""
    @Published var groupPhoto = ""
    @Published var userEntity: [UserEntity] = [UserEntity]()
    
    func load(id: Int) {
        userEntity = coreDataManager.fetchUserId(with: id)
        bio = userEntity.first?.bio ?? ""
        unread_count = Int(userEntity.first?.unread_count ?? 0)
        name = userEntity.first?.name ?? ""
        groupPhoto = userEntity.first?.group_photo ?? ""
        print(userEntity.first?.bio ?? "")
    }
}

