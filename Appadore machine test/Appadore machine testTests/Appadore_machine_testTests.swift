//
//  Appadore_machine_testTests.swift
//  Appadore machine testTests
//
//  Created by Apple on 07/07/24.
//

import XCTest
@testable import Appadore_machine_test
import SwiftUI
import CoreData
final class Appadore_machine_testTests: XCTestCase {
    let coreDataManager = CoreDataManager()
    let context = PersistenceController.shared.container.viewContext
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserListEndPoint () async{
        let expectation = XCTestExpectation(description: "Fetch data from API")
        ApiManager.getData(api: "\(devUrl())") { response in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(Groups_Base.self, from: response)
                XCTAssertTrue((responseModel.message == "OK"),"Data not received from API")
                expectation.fulfill()
            }catch{
            }
        } failure: { Error in
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSaveCoreData () {
        coreDataManager.saveUser(
            bio: "test bio",
            group_photo:  "https://messej-backend.s3.amazonaws.com/development/huddles/profile_photos/9c0b0f93db93415c9b60f0c753974844.jpg",
            id: 1001,
            name:  "dhilipan",
            participant_count: 501,
            mprivate: false,
            unread_count:  301,
            user_status:  "Invited"
        )
        
        let data  = coreDataManager.fetchUserId(with: 1001)
        print("##\(data.first?.user_status)")
        XCTAssertTrue((data.first?.user_status == "Invited"),"Data not saved in Core Data")

    }

}
