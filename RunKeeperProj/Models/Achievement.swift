//
//  Acievement.swift
//  RunKeeperProj
//
//  Created by Chris Campanelli on 2020-09-22.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import Foundation

// Explination of fields that make up an Achievement
// id                -> db id
// title             -> title of achievement
// description       -> currently unused was thinking it could be used to provide a description if
// distanceCompleted -> height/elevation of the achievement
// secondsCompleted  -> seconds taken to complete achievement
// url               -> address to fetch achievement badge
// complete          -> (not implemented) has the achievement been completed, used to show cell is inActive
// rank              -> (not implemented) used to sort the order which achievements appear
// achievementType   -> used to put achievement into correct section
// measurementMetricType -> used to determine what metric to display in UI (distanceCompleted or secondsCompleted)

struct Achievement : Codable {
    enum CodingKeys:  String, CodingKey {
        case
            id,
            title,
            description,
            distanceCompleted,
            secondsCompleted,
            url,
            complete,
            rank,
            achievementType,
            measurementMetricType
    }
    
    let title, description, url: String?
    let id, rank, secondsCompleted, distanceCompleted: Int?
    let complete: Bool
    let achievementType: AchievementType
    let measurementMetricType: MeasurementMetricType
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey:.title) ?? nil
        description = try values.decodeIfPresent(String.self, forKey:.description) ?? nil
        url = try values.decodeIfPresent(String.self, forKey:.url) ?? nil

        id = try values.decodeIfPresent(Int.self, forKey:.id) ?? nil
        rank = try values.decodeIfPresent(Int.self, forKey:.rank) ?? nil
        distanceCompleted = try values.decodeIfPresent(Int.self, forKey:.distanceCompleted) ?? nil
        secondsCompleted = try values.decodeIfPresent(Int.self, forKey:.secondsCompleted) ?? nil
        complete = try values.decodeIfPresent(Bool.self, forKey:.complete) ?? false

        achievementType = try values.decodeIfPresent(AchievementType.self, forKey:.achievementType) ?? AchievementType.UNKNOWN
        measurementMetricType = try values.decodeIfPresent(MeasurementMetricType.self, forKey:.measurementMetricType) ?? MeasurementMetricType.UNKNOWN
    }
    
    public func getMetricText() -> String? {
        switch measurementMetricType {
        case .Distance:
            return self.distanceCompleted?.toDistanceTimeString()
        case .Time:
            return self.secondsCompleted?.toEventTimeString()
        default:
            return nil
        }
    }
}

enum AchievementType: Int, Codable, CaseIterable{
    case Personal,
         VirtualRace,
         UNKNOWN
}

enum MeasurementMetricType: Int, Codable, CaseIterable {
    case Time,
         Distance,
         UNKNOWN
}
