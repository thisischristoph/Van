//
//  Location.swift
//  Van
//
//  Created by Christopher Harrison on 20/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import MapKit

struct Location {
    let key: String
    let location: CLLocation
    
    init(key: String, location: CLLocation) {
        self.key = key
        self.location = location
    }
}
