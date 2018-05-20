//
//  VanExtension.swift
//  Van
//
//  Created by Christopher Harrison on 18/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Foundation

extension Van {
    
    func toDictionary() -> [String: Any] {
        var van: [String : Any] = [
            VanKeys.uid.rawValue : self.uid,
            VanKeys.name.rawValue : self.name,
            VanKeys.profilePicURL.rawValue : self.profilePicURL
        ]
        let openingTimesMonday: [String : Any] = [
            DayKeys.opens.rawValue : self.openingTimes.monday.opens ?? 0,
            DayKeys.closes.rawValue : self.openingTimes.monday.closes ?? 0,
            DayKeys.closed.rawValue : self.openingTimes.monday.closed ?? false
        ]
        let openingTimesTuesday: [String : Any] = [
            DayKeys.opens.rawValue : self.openingTimes.tuesday.opens ?? 0,
            DayKeys.closes.rawValue : self.openingTimes.tuesday.closes ?? 0,
            DayKeys.closed.rawValue : self.openingTimes.tuesday.closed ?? false
        ]
        let openingTimesWednesday: [String : Any] = [
            DayKeys.opens.rawValue : self.openingTimes.wednesday.opens ?? 0,
            DayKeys.closes.rawValue : self.openingTimes.wednesday.closes ?? 0,
            DayKeys.closed.rawValue : self.openingTimes.wednesday.closed ?? false
        ]
        let openingTimesThursday: [String : Any] = [
            DayKeys.opens.rawValue : self.openingTimes.thursday.opens ?? 0,
            DayKeys.closes.rawValue : self.openingTimes.thursday.closes ?? 0,
            DayKeys.closed.rawValue : self.openingTimes.thursday.closed ?? false
        ]
        let openingTimesFriday: [String : Any] = [
            DayKeys.opens.rawValue : self.openingTimes.friday.opens ?? 0,
            DayKeys.closes.rawValue : self.openingTimes.friday.closes ?? 0,
            DayKeys.closed.rawValue : self.openingTimes.friday.closed ?? false
        ]
        let openingTimesSaturday: [String : Any] = [
            DayKeys.opens.rawValue : self.openingTimes.saturday.opens ?? 0,
            DayKeys.closes.rawValue : self.openingTimes.saturday.closes ?? 0,
            DayKeys.closed.rawValue : self.openingTimes.saturday.closed ?? false
        ]
        let openingTimesSunday: [String : Any] = [
            DayKeys.opens.rawValue : self.openingTimes.sunday.opens ?? 0,
            DayKeys.closes.rawValue : self.openingTimes.sunday.closes ?? 0,
            DayKeys.closed.rawValue : self.openingTimes.sunday.closed ?? false
        ]
        
        van[VanKeys.openingTimes.rawValue] = [
            OpeningTimesKeys.monday.rawValue : openingTimesMonday,
            OpeningTimesKeys.tuesday.rawValue : openingTimesTuesday,
            OpeningTimesKeys.wednesday.rawValue : openingTimesWednesday,
            OpeningTimesKeys.thursday.rawValue : openingTimesThursday,
            OpeningTimesKeys.friday.rawValue : openingTimesFriday,
            OpeningTimesKeys.saturday.rawValue : openingTimesSaturday,
            OpeningTimesKeys.sunday.rawValue : openingTimesSunday
            ]
        
        return van
        
    }
}
