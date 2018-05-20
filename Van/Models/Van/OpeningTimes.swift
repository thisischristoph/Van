//
//  OpeningTimes.swift
//  Van
//
//  Created by Christopher Harrison on 18/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Firebase

struct OpeningTimes {
    let key: String
    let monday: Day
    let tuesday: Day
    let wednesday: Day
    let thursday: Day
    let friday: Day
    let saturday: Day
    let sunday: Day
    let ref: DatabaseReference?
    
    init(
        key: String,
        monday: Day,
        tuesday: Day,
        wednesday: Day,
        thursday: Day,
        friday: Day,
        saturday: Day,
        sunday: Day
        ) {
        self.key = key
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        monday = Day(snapshot: snapshot.childSnapshot(forPath: OpeningTimesKeys.monday.rawValue))
        tuesday = Day(snapshot: snapshot.childSnapshot(forPath: OpeningTimesKeys.tuesday.rawValue))
        wednesday = Day(snapshot: snapshot.childSnapshot(forPath: OpeningTimesKeys.wednesday.rawValue))
        thursday = Day(snapshot: snapshot.childSnapshot(forPath: OpeningTimesKeys.thursday.rawValue))
        friday = Day(snapshot: snapshot.childSnapshot(forPath: OpeningTimesKeys.friday.rawValue))
        saturday = Day(snapshot: snapshot.childSnapshot(forPath: OpeningTimesKeys.saturday.rawValue))
        sunday = Day(snapshot: snapshot.childSnapshot(forPath: OpeningTimesKeys.sunday.rawValue))
        ref = snapshot.ref
    }
}
