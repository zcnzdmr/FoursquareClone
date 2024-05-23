//
//  DetailPage.swift
//  FoursquareClone
//
//  Created by Özcan on 21.05.2024.
//

import UIKit
import SDWebImage
import MapKit

class DetailPage: UIViewController {
    
    var mapKit = MKMapView()
    
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
        setUpUIs()
        assignFonk()
        mapkit()
    }
    
    // MARK: Görsel Nesneleri oluşturma
    private func setUpUIs() {
        
        view.backgroundColor = .systemBackground
        let screenWidth = view.frame.size.width
        
        imageViewm.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 250)
//        imageViewm.layer.borderWidth = 0.7
        imageViewm.translatesAutoresizingMaskIntoConstraints = true
//        imageViewm.image = UIImage(named: "arkaplan")
        view.addSubview(imageViewm)
        
        label1.frame = CGRect(x: 5, y: 360, width: (screenWidth - 10), height: 40)
//        label1.layer.cornerRadius = 10
//        label1.layer.borderWidth = 0.3
        label1.textAlignment = .center
        view.addSubview(label1)
        
        label2.frame = CGRect(x: 5, y: 405, width: (screenWidth - 10), height: 40)
//        label2.layer.cornerRadius = 10
//        label2.layer.borderWidth = 0.3
        label2.textAlignment = .center
        view.addSubview(label2)
        
        label3.frame = CGRect(x: 5, y: 450, width: (screenWidth - 10), height: 40)
//        label3.layer.cornerRadius = 10
//        label3.layer.borderWidth = 0.3
        label3.textAlignment = .center
        view.addSubview(label3)
        
        //        NSLayoutConstraint.activate([
        //            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
        //            nextButton.widthAnchor.constraint(equalToConstant: 80),
        //            nextButton.heightAnchor.constraint(equalToConstant: 100)
        //                ])
    }
    
    func mapkit() {
        
        let screenWidth = view.bounds.size.width
        let screenHeight = view.bounds.size.height
        
        mapKit.frame = CGRect(x: 0, y: 520, width: screenWidth, height: (screenHeight - 540))
        mapKit.layer.borderWidth = 0.7
        
        if let latitudex = latitude, let longitudex = longitude {
            let konum = CLLocationCoordinate2D(latitude: latitudex, longitude: longitudex)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: konum, span: span)
            mapKit.setRegion(region, animated: true)
            view.addSubview(mapKit)
        }
    }
    
    
    // MARK: HomePage gelen verileri aktaran fonk.
    func assignFonk() {
        
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
            mapKit.addAnnotation(pin)
        }
    }
}
