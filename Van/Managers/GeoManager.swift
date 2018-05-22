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
    
    func getLocation(for key: String, completion: @escaping () -> Void) {
        vanGeoRef.getLocationForKey(key) { (location, error) in
            if (error != nil) {
                print(String(describing: error?.localizedDescription))
            } else if (location != nil) {
                self.updateLocations(with: Location(key: key, location: location!)){ }
                completion()
            } else {
                print("GeoFire does not contain a location for \(key)")
            }
        }
    }
    
    func updateLocations(with location: Location, maintainLocation: Bool = true, completion: @escaping () -> Void) {
        var updatedLocations = GeoManager.shared.locations.filter { (oldLocation) -> Bool in
            oldLocation.key != location.key
        }
        if maintainLocation {
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
        GeoManager.shared.updateLocations(with: Location(key: key, location: location), maintainLocation: track) {
            MapManager.shared.updateAnnotations {
                MapManager.shared.update(map)
            }
        }
    }
}
