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
    
    let vanGeoRef: GeoFire = GeoFire(firebaseRef: FirebaseManager.shared.rootRef.child(GeoKeys.vanLocations.rawValue))
    
    func setVanLocation(location: CLLocation, uid: String) {
        vanGeoRef.setLocation(location, forKey: uid)
    }
    
    func removeVanLocation(for uid: String) {
        vanGeoRef.removeKey(uid)
    }
    
    func updateLocations(with location: Location, track: Bool = true, completion: @escaping () -> Void) {
        var updatedLocations = GeoManager.shared.locations.filter { (oldLocation) -> Bool in
            oldLocation.key != location.key
        }
        if track {
           updatedLocations.append(location)
        }
        GeoManager.shared.locations = updatedLocations
        completion()
    }
    
    func observeVanLocations(for map: MKMapView, in radius: Double) {
        let query = vanGeoRef.query(at: LocationManager.shared.userLocation, withRadius: radius)
        query.observe(.keyEntered) { (key, location) in
            self.update(map, key, location)
        }
        query.observe(.keyExited) { (key, location) in
            self.update(map, key, location, track: false)
        }
        query.observe(.keyMoved) { (key, location) in
            self.update(map, key, location)
        }
    }
    
    func update(_ map: MKMapView, _ key: String, _ location: CLLocation, track: Bool = true) {
        GeoManager.shared.updateLocations(with: Location(key: key, location: location), track: track) {
            MapManager.shared.updateAnnotations {
                MapManager.shared.update(map)
            }
        }
    }
}
