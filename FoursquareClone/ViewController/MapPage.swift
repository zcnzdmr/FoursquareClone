//
//  MapPage.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit
import MapKit

class MapPage: UIViewController {
    
    var mapKit = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Mapkit()

        // Do any additional setup after loading the view.
    }
    
    // MARK: MapKit view kısmı
    func Mapkit() {
        mapKit.frame = view.bounds
        let konum = CLLocationCoordinate2D(latitude: 40.785834, longitude: 30.406417)
        let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        mapKit.setRegion(bolge, animated: true)
        view.addSubview(mapKit)
        
    }
}
