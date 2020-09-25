//
//  AchievementsManager.swift
//  RunKeeperProj
//
//  Created by Chris Campanelli on 2020-09-22.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import UIKit

protocol AchievementManagerDelegate {
    func onAchievementsUpdated(achievementList:[Achievement])
}

class AchievementManager {
    static let shared = AchievementManager()
    var achievementList = [Achievement]()
    var achievementDelegate: AchievementManagerDelegate?
    
    private init(){
        // Do nothing
    }
    
    func handleSyncResponseData(achievementList:[Achievement]) {
        self.achievementList = achievementList
        downloadAchievementImages(achievementList: achievementList)
        achievementDelegate?.onAchievementsUpdated(achievementList:achievementList)
    }
    
    // ToDo: Given more time, I would like to persist these images to documents,
    // so that on app start they don't have to be re downloaded everytime
    func downloadAchievementImages(achievementList:[Achievement]) {
        for achievement in achievementList {
            guard let achievementUrl = achievement.url else { continue }
            
            if ImageCache.shared.imageExists(forKey: achievementUrl) {
                continue
            }
            
            if let url = URL.init(string: achievementUrl) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print("error loading image: \(String(describing: error))")
                        return
                    }
                    // On download completion, write image to cache
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            ImageCache.shared.set(image: downloadedImage, forKey: achievementUrl)
                        }
                    }
                }).resume()
            }
        }
    }
}
