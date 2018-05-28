//
//  MapManager.swift
//  Van
//
//  Created by Christopher Harrison on 20/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import Foundation
import MapKit

struct MapManager {
    
    static var shared = MapManager()
    
    var annotations: [MKAnnotation] = []
    
    func update(_ map: MKMapView) {
            let sequence = diff(map.annotations, MapManager.shared.annotations, with: { (map, new) -> Bool in
                map.title == new.title &&
                map.subtitle == new.subtitle &&
                map.coordinate.latitude == new.coordinate.latitude &&
                map.coordinate.longitude == new.coordinate.longitude
            })
            map.removeAnnotations(sequence.removed)
            map.addAnnotations(sequence.inserted)


    }
    
    func updateAnnotations(completion: @escaping () -> Void) {
        var newAnnotations: [MKAnnotation] = []
        GeoManager.shared.locations.forEach { (location) in
            if let van = VanManager.shared.getVan(for: location.key) {
                let annotation = VanAnnotation(coordinate: location.location.coordinate, van: van)
                newAnnotations.append(annotation)
            }
        }
        MapManager.shared.annotations = newAnnotations
        completion()
    }
    
}
