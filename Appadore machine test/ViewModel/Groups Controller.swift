//
//  GroupsController.swift
//  Appadore machine test
//
//  Created by Apple on 07/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import SwiftUI
import Foundation
import CoreData

class GroupsController: ObservableObject {
    let coreDataManager = CoreDataManager()
    let context = PersistenceController.shared.container.viewContext
    
    @Published var param = [String: Any]()
    @Published var groups = [Groups]()
    @Published var userEntity: [UserEntity] = [UserEntity]()
    
    func load(param: [String: Any]) async {
        await addUser(param: param)
    }
    
    func getUserLoad() async {
        //  await getUserList()
        await POCgetUserList()
    }
    
    @MainActor func addUser(param: [String: Any]) async {
        ApiManager.postData(api: "\(devUrl())", param: param) { response in
            print("Response: \(response.description)")
        } failure: { error in
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @MainActor func getUserList() async {
        ApiManager.getData(api: "\(devUrl())") { [self] response in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Groups_Base.self, from: response)
                groups = responseModel.result?.groups ?? []
                print(groups)
                Task {
                    await saveUsersToCoreData()
                    userEntity = coreDataManager.fetchUser()
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        } failure: { error in
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }
    
     func POCgetUserList() async {
        POC_APIManager.shared.get(endpoint: devUrl()) { (result: Result<Groups_Base, APIError>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let mdata):
                    groups = mdata.result?.groups ?? []
                    Task {
                        await saveUsersToCoreData()
                        userEntity = coreDataManager.fetchUser()
                    }
                case .failure(let error):
                    print("  failed: \(error)")
                   
                }
            }
        }
    }
    
    
    // MARK: - Save CoreData
    func saveUsersToCoreData() async {
        for user in groups {
            if !userExists(withID: user.id ?? 0) {
                coreDataManager.saveUser(
                    bio: user.bio ?? "",
                    group_photo: user.group_photo ?? "",
                    id: user.id ?? 0,
                    name: user.name ?? "",
                    participant_count: user.participant_count ?? 0,
                    mprivate: user.mprivate ?? false,
                    unread_count: user.unread_count ?? 0,
                    user_status: user.user_status ?? ""
                )
            }
        }
    }
    
    func userExists(withID id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(id)" )
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to fetch user: \(error)")
            return false
        }
    }
}

