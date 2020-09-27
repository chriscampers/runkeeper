//
//  SyncManager.swift
//  RunKeeperProj
//
//  Created by Chris Campanelli on 2020-09-22.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import Foundation

// This class is used to simulate the app syncing data from the server.
// Although currently not connected to API's see data.json file
class SyncManager {

    static let shared = SyncManager()
    private let achievementManager = AchievementManager.shared
    private init() {
        syncRecieved()
    }
    
    func syncRecieved() {
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
        let JSON = try! JSONSerialization.data(withJSONObject: jsonObject, options: [])
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
            let achievementList = try jsonDecoder.decode([Achievement].self, from: JSON)
            achievementManager.handleSyncResponseData(achievementList: achievementList)
        } catch let error {
            // Given more time, this error should be logged in way to so that at the
            // very least it is displayable in an external error monitoring system
            // like Crashlytics
            print(error)
        }
    }
}
