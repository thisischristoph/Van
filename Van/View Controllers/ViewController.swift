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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    
    var geoRef: GeoFire!
    var query: GFCircleQuery!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocationManager()
        geoRef = GeoFire(firebaseRef: FirebaseManager.shared.rootRef.child(GeoKeys.userLocations.rawValue))
        
        query = geoRef.query(at: UserManager.shared.userLocation, withRadius: 1000)
        query.observe(.keyEntered, with: { key, location in
            print("Key: " + key + "entered the search radius.")
        })
        FirebaseManager.shared.observeVans {
            VanManager.shared.vans.forEach({ (van) in
                GeoManager.shared.getLocation(for: van.key, completion: {
                    MapManager.shared.createAnnotations {
                        MapManager.shared.updateAnnotations(on: self.mapView)
                    }
                })
            })
        }
        
        
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        if currentLocation == nil {
            if let location = locations.last {
                UserManager.shared.userLocation = location
                let viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
                mapView.setRegion(viewRegion, animated: true)
                geoRef.setLocation(location, forKey: "chris")
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.topLeftCoordinate())
        print(mapView.bottomRightCoordinate())
    }
    
    @IBAction func addVanButtonPressed(_ sender: Any) {
        //VanManager.shared.addVan()
    }
    
    @IBAction func addVanToLocationWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.began { return }
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        VanManager.shared.addVan(with: CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude))
    }
    
}

