//
//  Van.swift
//  Van
//
//  Created by Christopher Harrison on 18/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Firebase

struct User {
    let key: String
    let uid: String
    let name: String
    let username: String
    let profilePicURL: String
    let ref: DatabaseReference?
    
    init(
        key: String,
        uid: String,
        name: String,
        username: String,
        profilePicURL: String
        ) {
        self.key = key
        self.uid = uid
        self.name = name
        self.username = username
        self.profilePicURL = profilePicURL
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        uid = snapshotValue[UserKeys.uid.rawValue] as! String
        name = snapshotValue[UserKeys.name.rawValue] as! String
        username = snapshotValue[UserKeys.username.rawValue] as! String
        profilePicURL = snapshotValue[UserKeys.profilePicURL.rawValue] as! String
        ref = snapshot.ref
    }
}
