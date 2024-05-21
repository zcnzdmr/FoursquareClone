//
//  DetailPage.swift
//  FoursquareClone
//
//  Created by Özcan on 21.05.2024.
//

import UIKit
import SDWebImage

class DetailPage: UIViewController {
    
    
    var imageViewm = UIImageView()
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    
    var nameArray     : String?
    var typeArray     : String?
    var commentArray  : String?
    var urlArray      : String?
    
    init(nameArray:String,typeArray: String,commentArray : String,urlArray : String){
        super.init(nibName: nil, bundle: nil)
        self.nameArray = nameArray
        self.typeArray = typeArray
        self.commentArray = commentArray
        self.urlArray = urlArray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIs()
        assignFonk()
    }
    
    private func setUpUIs() {
        
        view.backgroundColor = .systemBackground
        let screenWidth = view.frame.size.width
        
        imageViewm.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 300)
        imageViewm.layer.borderWidth = 0.7
        imageViewm.translatesAutoresizingMaskIntoConstraints = true
        imageViewm.image = UIImage(named: "arkaplan")
        view.addSubview(imageViewm)
        
        label1.frame = CGRect(x: 5, y: 450, width: (screenWidth - 10), height: 40)
        label1.layer.borderWidth = 0.7
        view.addSubview(label1)
        
        label2.frame = CGRect(x: 5, y: 500, width: (screenWidth - 10), height: 40)
        label2.layer.borderWidth = 0.7
        view.addSubview(label2)
        
        label3.frame = CGRect(x: 5, y: 550, width: (screenWidth - 10), height: 40)
        label3.layer.borderWidth = 0.7
        view.addSubview(label3)
        
        //        NSLayoutConstraint.activate([
        //            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
        //            nextButton.widthAnchor.constraint(equalToConstant: 80),
        //            nextButton.heightAnchor.constraint(equalToConstant: 100)
        //                ])
    }
    
    func assignFonk() {
//        if let url = URL(string: urlArray) {
//            DispatchQueue.main.async {
//                self.imageViewm.sd_setImage(with: url)
//            }
            self.label1.text = nameArray
            self.label2.text = typeArray
            self.label3.text = commentArray
        }

}
