//
//  MapPin.swift
//  Van
//
//  Created by Christopher Harrison on 20/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import MapKit

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
