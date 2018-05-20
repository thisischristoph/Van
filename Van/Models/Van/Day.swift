//
//  Day.swift
//  Van
//
//  Created by Christopher Harrison on 18/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Firebase

struct Day {
    let key: String
    let opens: Int?
    let closes: Int?
    let closed: Bool?
    let ref: DatabaseReference?
    
    init(
        key: String,
        opens: Int?,
        closes: Int?,
        closed: Bool?
        ) {
        self.key = key
        self.opens = opens
        self.closes = closes
        self.closed = closed
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        opens = snapshotValue[DayKeys.opens.rawValue] as? Int
        closes = snapshotValue[DayKeys.closes.rawValue] as? Int
        closed = snapshotValue[DayKeys.closed.rawValue] as? Bool
        ref = snapshot.ref
    }
}

