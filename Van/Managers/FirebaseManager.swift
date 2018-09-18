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
    
    func observeNearbyVans(completion: @escaping () -> Void) {
        GeoManager.shared.locations.forEach { (location) in
            FirebaseManager.shared.rootRef.child(VanKeys.vans.rawValue).child(location.key).observeSingleEvent(of: .value, with: { (snapshot) in
                let van = Van(snapshot: snapshot)
                VanManager.shared.updateVans(with: van)
                completion()
            })
        }
    }
}
