//
//  FirebaseManager.swift
//  Van
//
//  Created by Christopher Harrison on 17/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Firebase

struct FirebaseManager {
    
    static var shared = FirebaseManager()
    
    let rootRef = Database.database().reference()
    
    func observeVans(completion: @escaping () -> Void) {
        FirebaseManager.shared.rootRef.child(VanKeys.vans.rawValue).observe(.value) { (snapshot) in
            var updatedVans: [Van] = []
            for item in snapshot.children {
                let van = Van(snapshot: item as! DataSnapshot)
                updatedVans.append(van)
            }
            VanManager.shared.vans = updatedVans
            completion()
        }
    }
}
