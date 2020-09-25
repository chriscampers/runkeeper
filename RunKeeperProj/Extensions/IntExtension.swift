//
//  IntExtension.swift
//  RunKeeperProj
//
//  Created by Christopher Campanelli on 2020-09-23.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import Foundation

extension Int {
    func toEventTimeString() -> String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.unitsStyle = .positional

        let formattedDateString = dateFormatter.string(from: TimeInterval(self))!
        return formattedDateString
    }
    
    func toDistanceTimeString() -> String {
        return "\(self) m"
    }
}
