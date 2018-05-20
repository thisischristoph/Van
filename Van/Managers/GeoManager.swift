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
                print("An error occurred getting the location for \"firebase-hq\": \(String(describing: error?.localizedDescription))")
            } else if (location != nil) {
                print("Location for \"firebase-hq\" is [\(String(describing: location?.coordinate.latitude)), \(String(describing: location?.coordinate.longitude))]")
                self.updateLocations(with: Location(key: key, location: location!))
                completion()
            } else {
                print("GeoFire does not contain a location for \"firebase-hq\"")
            }
        }
    }
    
    func updateLocations(with location: Location) {
        var updatedLocations = GeoManager.shared.locations.filter { (oldLocation) -> Bool in
            oldLocation.key != location.key
        }
        updatedLocations.append(location)
        GeoManager.shared.locations = updatedLocations
    }
}
