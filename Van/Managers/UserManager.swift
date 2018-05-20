//
//  UserManager.swift
//  Van
//
//  Created by Christopher Harrison on 15/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import MapKit

struct UserManager {
    
    static var shared = UserManager()
    
    var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
}
