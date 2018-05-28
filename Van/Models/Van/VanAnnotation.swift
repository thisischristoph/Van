//
//  MapPin.swift
//  Van
//
//  Created by Christopher Harrison on 20/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import MapKit

class VanAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var van: Van
    
    
    init(coordinate: CLLocationCoordinate2D, van: Van) {
        self.coordinate = coordinate
        self.van = van
    }
    
    var title: String? {
        return van.name
    }
    
    var subtitle: String? {
        return van.category
    }
}
