//
//  Appadore_machine_testApp.swift
//  Appadore machine test
//
//  Created by Apple on 07/07/24.
//

import SwiftUI

@main
struct Appadore_machine_testApp: App {
    let persistenceController = PersistenceController.shared
    let  groupsController = GroupsController()
    var body: some Scene {
        WindowGroup {
         //   AboutGroup()
           Groups_View().environmentObject(groupsController)
           
        }
    }
}
