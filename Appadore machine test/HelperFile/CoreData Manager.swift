//
//  CoreData Manager.swift
//  Appadore machine test
//
//  Created by Apple on 07/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let presistentContainert : NSPersistentContainer
    let context = PersistenceController.shared.container.viewContext
    init() {
        presistentContainert = NSPersistentContainer(name: "Appadore_machine_test")
        presistentContainert.loadPersistentStores { (description, error) in
            
            if let error = error {
                fatalError("Core data store failed to init\(error.localizedDescription)")
            }
        }
        
    }
    
    //MARK: -Save Data
    
    func saveUser(bio: String, group_photo: String, id: Int, name: String, participant_count: Int, mprivate:Bool, unread_count: Int, user_status: String) {
        let user = UserEntity(context: presistentContainert.viewContext)
        user.bio = bio
        user.id = Int16(id)
        user.group_photo = group_photo
        user.name = name
        user.participant_count = Int16(participant_count)
        user.mprivate = mprivate
        user.unread_count = Int16(unread_count)
        user.user_status = user_status
        do{
            try presistentContainert.viewContext.save()
            print("Data saved! ")
        }catch{
            print("Save data get error \(error)")
        }
    }
    
    //MARK: - Fetch Data
    
    func fetchUser() -> [UserEntity] {
        let fetchRequest:NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            return try presistentContainert.viewContext.fetch(fetchRequest)
        }catch{return []}
    }
    func fetchUserId(with id: Int?) -> [UserEntity] {
        guard let id = id else { return [] }
        let request = UserEntity.fetchRequest() as NSFetchRequest<UserEntity>
        request.predicate = NSPredicate(format: "id == %@", "\(id)")
        guard let userEntity = try? context.fetch(request) else { return [] }
        return userEntity
    }
    //MARK: - Update Data
    func updateUser() {
        do{
            try presistentContainert.viewContext.save()
            print("Data saved! ")
        }catch{
            presistentContainert.viewContext.rollback()
          print("Save data get error \(error)")
        }
    }
    //MARK: - Delete Data
    
    func deleteUser(userEntity:UserEntity) {
        presistentContainert.viewContext.delete(userEntity)
        do{
            try presistentContainert.viewContext.save()
        }catch{
             presistentContainert.viewContext.rollback()
            print ("fail to delete \(error.localizedDescription)")
        }
    }
}
    

