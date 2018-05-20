//
//  VanManager.swift
//  Van
//
//  Created by Christopher Harrison on 18/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Foundation
import Firebase
import MapKit


struct VanManager {
    
    static var shared = VanManager()
    
    var vans: [Van] = []
    
    func addVan(with coordiates: CLLocation) {
        let newVanRef: DatabaseReference = FirebaseManager.shared.rootRef.child(VanKeys.vans.rawValue).childByAutoId()
        let van = Van(
            key: newVanRef.key,
            uid: newVanRef.key,
            name: "Test van",
            profilePicURL: "",
            openingTimes: OpeningTimes(
                key: VanKeys.openingTimes.rawValue,
                monday: Day(key: OpeningTimesKeys.monday.rawValue, opens: 1, closes: 9, closed: false),
                tuesday: Day(key: OpeningTimesKeys.tuesday.rawValue, opens: 2, closes: 8, closed: true),
                wednesday: Day(key: OpeningTimesKeys.wednesday.rawValue, opens: 3, closes: 7, closed: true),
                thursday: Day(key: OpeningTimesKeys.thursday.rawValue, opens: 4, closes: 7, closed: false),
                friday: Day(key: OpeningTimesKeys.friday.rawValue, opens: 5, closes: 8, closed: false),
                saturday: Day(key: OpeningTimesKeys.saturday.rawValue, opens: 6, closes: 9, closed: true),
                sunday: Day(key: OpeningTimesKeys.sunday.rawValue, opens: 7, closes: 9, closed: false)
            )
        )
        newVanRef.setValue(van.toDictionary())
        GeoManager.shared.setVanLocation(location: coordiates, uid: newVanRef.key)
    }
    
    
    func getVan(for key: String) -> Van? {
        return vans.filter({ (van) -> Bool in
            van.key == key
        }).first
    }
}
