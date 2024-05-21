//
//  MapPage.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapPage: UIViewController {
    
    var mapKit = MKMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationFonk()
        longGesture()
        // Do any additional setup after loading the view.
    }
    
    func longGesture() {
        
        mapKit.isUserInteractionEnabled = true
        let gR2 = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation))
        gR2.minimumPressDuration = 2
        mapKit.addGestureRecognizer(gR2)
    }
    
    func locationFonk() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
    }
    
    // MARK: Annotation(pin) ekleme 
    
    @objc func addAnnotation(gesRec: UILongPressGestureRecognizer) {
        
        let annotation = MKPointAnnotation()
        
        let touchedLocation = gesRec.location(in: self.mapKit)
        let touchedCoordinate = mapKit.convert(touchedLocation, toCoordinateFrom: self.mapKit)
        
        annotation.coordinate = touchedCoordinate
        
        mapKit.addAnnotation(annotation)
        self.navigationController?.pushViewController(HomePage(), animated: true)
    }
    
}

extension MapPage : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lastLocation = locations[locations.count-1]
        
        let latitude = lastLocation.coordinate.latitude
        let longitude = lastLocation.coordinate.longitude
        
        mapKit.frame = view.bounds
        let konum = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        mapKit.setRegion(bolge, animated: true)
        view.addSubview(mapKit)
        
        
        
        
    }
    
}

