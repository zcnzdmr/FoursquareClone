//
//  MapPage.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore
import FirebaseStorage

class MapPage: UIViewController {
    
    var latitude = Double()
    var longitude = Double()
    
    var nameOfPlace : String?
    var typeOfPlace : String?
    var comment     : String?
    var imageUrl    : String?
    
    init(nameOfPlace:String,typeOfPlace : String,comment: String, imageUrl : String ) {
        super.init(nibName: nil, bundle: nil)
        self.nameOfPlace = nameOfPlace
        self.typeOfPlace = typeOfPlace
        self.comment     = comment
        self.imageUrl    = imageUrl
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mapKit = MKMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationFonk()
        longGesture()
        barButton()
        // Do any additional setup after loading the view.
    }
    
    func barButton() {
        let right = UIBarButtonItem(image: UIImage(systemName: "externaldrive.badge.plus"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(upLoadPhoto))
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func upLoadPhoto() {
        
        if let name = nameOfPlace, let type = typeOfPlace , let comment = comment, let imageUrl = imageUrl {
            
            
            // MARK: FireStore'a kayıt yapma
            
            let db = Firestore.firestore()
            
            let dataDict : [String:Any] = ["nameOfPlace"   : name,
                                           "typeOfPlace"   : type,
                                           "comment"       : comment,
                                           "date"          : FieldValue.serverTimestamp(),
                                           "latitude"      : latitude,
                                           "longitude"     : longitude,
                                           "imageUrl"      : imageUrl]
            
            db.collection("Places").addDocument(data: dataDict) { error in
                if error != nil {
                    
                    self.alert(title: "Error", message: error?.localizedDescription ?? "An error saving to Firestore ")
                }else{
                    self.navigationController?.show(HomePage(), sender: nil)
                }
            }
            
        }
    }
    
    // MARK: Alert fonksiyonu
    func alert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        self.present(alert,animated: true)
        
    }
    
    @objc func longGesture() {
        
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
        
        self.latitude = touchedCoordinate.latitude
        self.longitude = touchedCoordinate.longitude
        
        annotation.coordinate = touchedCoordinate
        
        if let yerAdi = nameOfPlace {
            annotation.title = yerAdi
        }
        
        mapKit.addAnnotation(annotation)
        
        //        self.navigationController?.pushViewController(HomePage(), animated: true)
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

