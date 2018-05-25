//
//  Van.swift
//  Van
//
//  Created by Christopher Harrison on 18/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Firebase
import MapKit

struct Van {

    let key: String
    let uid: String
    let name: String
    let profilePicURL: String
    let openingTimes: OpeningTimes
    let category: VanCategory
    let ref: DatabaseReference?
    
    init(
        key: String,
        uid: String,
        name: String,
        profilePicURL: String,
        openingTimes: OpeningTimes,
        category: VanCategory
        ) {
        self.key = key
        self.uid = uid
        self.name = name
        self.profilePicURL = profilePicURL
        self.openingTimes = openingTimes
        self.category = category
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        uid = snapshotValue[VanKeys.uid.rawValue] as! String
        name = snapshotValue[VanKeys.name.rawValue] as! String
        profilePicURL = snapshotValue[VanKeys.profilePicURL.rawValue] as! String
        openingTimes = OpeningTimes(snapshot: snapshot.childSnapshot(forPath: VanKeys.openingTimes.rawValue))
        category = (snapshotValue[VanKeys.category.rawValue] as! String).vanCategory()
        ref = snapshot.ref
    }
}
