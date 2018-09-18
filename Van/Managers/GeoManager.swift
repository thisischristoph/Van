//
//  GeoManager.swift
//  Van
//
//  Created by Christopher Harrison on 17/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import GeoFire

struct GeoManager {
    
    static var shared = GeoManager()
    
    var locations: [Location] = []
    var completedInitialLoad = false
    
    let vanGeoRef: GeoFire = GeoFire(firebaseRef: FirebaseManager.shared.rootRef.child(GeoKeys.vanLocations.rawValue))
    
    func setVanLocation(location: CLLocation, uid: String) {
        vanGeoRef.setLocation(location, forKey: uid)
    }
    
    func removeVanLocation(for uid: String) {
        vanGeoRef.removeKey(uid)
    }
    
    func observeVanLocations(for map: MKMapView, in radius: Double) {
        let query = vanGeoRef.query(at: LocationManager.shared.userLocation, withRadius: radius)
        query.observe(.keyEntered) { (key, location) in
            self.updateLocations(key: key, location: location)
            self.observeVans(on: map)
        }
        query.observe(.keyExited) { (key, location) in
            self.updateLocations(key: key, location: location, track: false)
            self.observeVans(on: map)
        }
        query.observe(.keyMoved) { (key, location) in
            self.updateLocations(key: key, location: location)
            self.observeVans(on: map)
        }
        query.observeReady {
            GeoManager.shared.completedInitialLoad = true
            self.observeVans(on: map)
        }
        
    }
    
    func observeVans(on map: MKMapView) {
        if GeoManager.shared.completedInitialLoad {
            FirebaseManager.shared.observeNearbyVans {
                MapManager.shared.update(map)
            }
        }
    }
    
    func updateLocations(key: String?, location: CLLocation?, track: Bool = true) {
        guard let key = key, let location = location else {
            return
        }
        let newLocation = Location(key: key, location: location)
        var updatedLocations = GeoManager.shared.locations.filter { (oldLocation) -> Bool in
            oldLocation.key != newLocation.key
        }
        if track {
            updatedLocations.append(newLocation)
        }
        GeoManager.shared.locations = updatedLocations
    }
}
