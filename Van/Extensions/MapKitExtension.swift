//
//  MapKitExtension.swift
//  Van
//
//  Created by Christopher Harrison on 14/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import MapKit

extension MKMapView {
    func topLeftCoordinate() -> CLLocationCoordinate2D {
        return convert(CGPoint.zero, toCoordinateFrom: self)
    }
    
    func bottomRightCoordinate() -> CLLocationCoordinate2D {
        return convert(CGPoint(x: frame.width, y: frame.height), toCoordinateFrom: self)
    }
}
