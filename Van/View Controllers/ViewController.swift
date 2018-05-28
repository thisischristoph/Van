//
//  ViewController.swift
//  Van
//
//  Created by Christopher Harrison on 14/05/2018.
//  Copyright © 2018 Christopher Harrison. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import GeoFire

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, LocationTrackable {
    
    @IBOutlet weak var mapView: MKMapView!
    private var currentLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocationManager()
        FirebaseManager.shared.observeVans { }
    }
    
    func setupLocationManager() {
        LocationManager.shared.locationManager.delegate = self
        LocationManager.shared.setup()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        if currentLocation == nil {
            if let location = locations.last {
                LocationManager.shared.userLocation = location
                GeoManager.shared.observeVanLocations(for: mapView, in: 10)
                let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
                mapView.setRegion(viewRegion, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.topLeftCoordinate())
        print(mapView.bottomRightCoordinate())
    }
    
    @IBAction func addVanToLocationWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        VanManager.shared.addVan(with: CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        
        if annotation is VanAnnotation {
            
        } else {
            return nil
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = #imageLiteral(resourceName: "iceCream")
        return annotationView
    }
    
    
    
}

