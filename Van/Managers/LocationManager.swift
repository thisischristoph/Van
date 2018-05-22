//
//  LocationManager.swift
//  Van
//
//  Created by Christopher Harrison on 21/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import MapKit

struct LocationManager {
    
    static var shared = LocationManager()
    
    var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var locationManager: CLLocationManager = CLLocationManager()
    
    func setup() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    
}
