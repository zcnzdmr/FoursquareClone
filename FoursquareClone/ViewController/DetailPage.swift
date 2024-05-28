//
//  DetailPage.swift
//  FoursquareClone
//
//  Created by Özcan on 21.05.2024.
//

import UIKit
import SDWebImage
import MapKit
import CoreLocation

class DetailPage: UIViewController {
    
    // MARK: Görsel Nesneleri Tanımlama
    var mapKit = MKMapView()
    var locationManager = CLLocationManager()
    
    var imageViewm = UIImageView()
    var label1     = UILabel()
    var label2     = UILabel()
    var label3     = UILabel()
    
    var nameArray     : String?
    var typeArray     : String?
    var commentArray  : String?
    var urlArray      : String?
    var latitude      : Double?
    var longitude     : Double?
    
    init(nameArray:String,typeArray: String,commentArray : String,urlArray : String, latitude : Double, longitude : Double){
        super.init(nibName: nil, bundle: nil)
        self.nameArray = nameArray
        self.typeArray = typeArray
        self.commentArray = commentArray
        self.urlArray = urlArray
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Detail Page"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                                                        NSAttributedString.Key.font : UIFont(name: "Papyrus", size: 20)!]
        
        setUpUIs()
        mapkit()
    }
    
    // MARK: Görsel Nesneleri Detaylandırma
    private func setUpUIs() {
        
        view.backgroundColor = .systemBackground
        let screenWidth = view.frame.size.width
        
        imageViewm.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 250)
        imageViewm.translatesAutoresizingMaskIntoConstraints = true
        imageViewm.layer.borderWidth = 1.5
        imageViewm.layer.borderColor = UIColor.systemYellow.cgColor
        view.addSubview(imageViewm)
        
        label1.frame = CGRect(x: 5, y: 360, width: (screenWidth - 10), height: 40)
        
        label1.textAlignment = .center
        view.addSubview(label1)
        
        label2.frame = CGRect(x: 5, y: 405, width: (screenWidth - 10), height: 40)
        label2.textAlignment = .center
        view.addSubview(label2)
        
        label3.frame = CGRect(x: 5, y: 450, width: (screenWidth - 10), height: 40)
        label3.textAlignment = .center
        view.addSubview(label3)
        
        //        NSLayoutConstraint.activate([
        //            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
        //            nextButton.widthAnchor.constraint(equalToConstant: 80),
        //            nextButton.heightAnchor.constraint(equalToConstant: 100)
        //                ])
    }
    
    // MARK: MapView'i oluşturma ve özelleştirme
    func mapkit() {
        
        let screenWidth = view.bounds.size.width
        let screenHeight = view.bounds.size.height
        
        mapKit.frame = CGRect(x: (screenWidth - 320) / 2, y: 500, width: 320, height: (screenHeight - 532))
        mapKit.layer.borderWidth = 0.7
        mapKit.layer.cornerRadius = mapKit.frame.size.width / 2
        mapKit.layer.borderColor = UIColor.black.cgColor
        
        if let latitudex = latitude, let longitudex = longitude {
            let konum = CLLocationCoordinate2D(latitude: latitudex, longitude: longitudex)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: konum, span: span)
            mapKit.setRegion(region, animated: true)
            view.addSubview(mapKit)
        }
        
        // MARK: HomePage gelen verileri aktaran kısım
        if let url = URL(string: urlArray!) {
            DispatchQueue.main.async {
                self.imageViewm.sd_setImage(with: url)
            }
            self.label1.text = nameArray
            self.label2.text = typeArray
            self.label3.text = commentArray
        }
        
        let pin = MKPointAnnotation()
        
        if let latitudex = latitude, let longitudex = longitude {
            pin.coordinate = CLLocationCoordinate2D(latitude: latitudex, longitude: longitudex)
            pin.title = nameArray
            pin.subtitle = typeArray
            mapKit.addAnnotation(pin)
        }
        
        mapKit.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}


// MARK: HomePage gelen verileri aktaran fonk.
//    func assignFonk() {
//
//        if let url = URL(string: urlArray!) {
//            DispatchQueue.main.async {
//                self.imageViewm.sd_setImage(with: url)
//            }
//            self.label1.text = nameArray
//            self.label2.text = typeArray
//            self.label3.text = commentArray
//        }
//
//        let pin = MKPointAnnotation()
//
//        if let latitudex = latitude, let longitudex = longitude {
//        pin.coordinate = CLLocationCoordinate2D(latitude: latitudex, longitude: longitudex)
//            pin.title = nameArray
//            pin.subtitle = typeArray
//            mapKit.addAnnotation(pin)
//        }
//    }



extension DetailPage : MKMapViewDelegate, CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseID = "myAnnotation"
        var pinView = mapKit.dequeueReusableAnnotationView(withIdentifier: reuseID ) as? MKMarkerAnnotationView
        
        if pinView == nil {
            
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            pinView?.tintColor = .orange
            
            let buttonPin = UIButton(type: UIButton.ButtonType.infoLight )
            pinView?.rightCalloutAccessoryView = buttonPin
            
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    // MARK: Callout'da ki butona tiklanınca navigasyon açma
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let alert = UIAlertController(title: "Route", message: "\(nameArray!) a rota oluşturulsun mu ?", preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.destructive)
        alert.addAction(noAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { alertAction in
            
            if let latitudex = self.latitude, let longitudex = self.longitude {
                let destinationCoordinate = CLLocationCoordinate2D(latitude: latitudex, longitude: longitudex)
                let placemark = MKPlacemark(coordinate: destinationCoordinate)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = self.nameArray

                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps(launchOptions: launchOptions)
            }
        }
        alert.addAction(yesAction)
        
        present(alert, animated: true)
    }
}
