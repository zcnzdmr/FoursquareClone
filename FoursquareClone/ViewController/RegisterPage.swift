//
//  RegisterPage.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class RegisterPage: UIViewController {
    
    var imageViewm = UIImageView()
    var textField1 = UITextField()
    var textField2 = UITextField()
    var textField3 = UITextField()
    var nextButton = UIButton()
    var urlString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIs()
        tapGesture()
    }
    
    // MARK: Görsel Nesneleri ayarlama kısmı
    private func setUpUIs() {
        
        view.backgroundColor = .systemBackground
        let screenWidth = view.frame.size.width
        
        imageViewm.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 300)
        imageViewm.layer.borderWidth = 0.7
        imageViewm.translatesAutoresizingMaskIntoConstraints = true
        imageViewm.image = UIImage(named: "arkaplan")
        view.addSubview(imageViewm)
        
        textField1.frame = CGRect(x: 5, y: 450, width: (screenWidth - 10), height: 40)
        textField1.layer.borderWidth = 0.7
        textField1.placeholder = "Enter the name of place"
        view.addSubview(textField1)
        
        textField2.frame = CGRect(x: 5, y: 500, width: (screenWidth - 10), height: 40)
        textField2.layer.borderWidth = 0.7
        textField2.placeholder = "Enter the type of place"
        view.addSubview(textField2)
        
        textField3.frame = CGRect(x: 5, y: 550, width: (screenWidth - 10), height: 40)
        textField3.layer.borderWidth = 0.7
        textField3.placeholder = "Enter the attribute of place"
        view.addSubview(textField3)
        
        nextButton.frame = CGRect(x: (screenWidth - 80) / 2 , y: 610, width:    80, height: 100)
        nextButton.setImage(UIImage(systemName: "arrowshape.right"), for: UIControl.State.normal)
        nextButton.tintColor = .black
        nextButton.translatesAutoresizingMaskIntoConstraints = true
        nextButton.addTarget(self, action: #selector(upLoadData), for: UIControl.Event.touchUpInside)
        view.addSubview(nextButton)
        
        //        NSLayoutConstraint.activate([
        //            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
        //            nextButton.widthAnchor.constraint(equalToConstant: 80),
        //            nextButton.heightAnchor.constraint(equalToConstant: 100)
        //                ])
    }
    
    // MARK: UILongGestureRecog. oluşturma kısmı
    func tapGesture() {
        imageViewm.isUserInteractionEnabled = true
        let gR = UITapGestureRecognizer(target: self, action: #selector(showImagePickerController))
        imageViewm.addGestureRecognizer(gR)
    }
    
    // MARK: FirebaseStorage'a image kaydetme kısmı
    @objc func upLoadData() {
        
        let storage = Storage.storage()
        let reference = storage.reference()
        let mediaFolder = reference.child("media")
        let uuid = UUID().uuidString
        
        if let imageGallery = imageViewm.image?.pngData() {
            
            let imageReference = mediaFolder.child("\(uuid).png")
            
            imageReference.putData(imageGallery, metadata: nil) { StorageMetadata, error in
                
                if error != nil {
                    
                    self.alert(title: "Error", message: error?.localizedDescription ?? "while saving images an error came up")
                }else{
                    
                    imageReference.downloadURL { url, error in
                        
                        if error != nil {
                            self.alert(title: "URL Error", message: error?.localizedDescription ?? "url error")
                            
                        }else{
                            
                            if let imageUrl = url?.absoluteString {
                                
                                if let name = self.textField1.text, let type = self.textField2.text, let comment = self.textField3.text {
                                    self.navigationController?.pushViewController(MapPage(nameOfPlace: name,
                                                                                          typeOfPlace: type,
                                                                                          comment: comment,
                                                                                          imageUrl: imageUrl), animated: true)
                                    
                                    self.textField1.text = ""
                                    self.textField2.text = ""
                                    self.textField3.text = ""
                                    
                                    
                                    //                                // MARK: FireStore'a kayıt yapma
                                    //
                                    //                                let db = Firestore.firestore()
                                    //
                                    //                                let dataDict : [String:Any] = ["nameOfPlace"   : self.textField1.text!,
                                    //                                                               "typeOfPlace"   : self.textField2.text!,
                                    //                                                               "comment"       : self.textField3.text!,
                                    //                                                               "date"          : FieldValue.serverTimestamp(),
                                    //                                                               "latitude"      : "",
                                    //                                                               "longitude"     : "",
                                    //                                                               "imageUrl"      : imageUrl]
                                    //
                                    //                                db.collection("Places").addDocument(data: dataDict) { error in
                                    //                                    if error != nil {
                                    //
                                    //                                        self.alert(title: "Error", message: error?.localizedDescription ?? "An error saving to Firestore ")
                                    //                                    }else{
                                    //                                        self.imageViewm.image = UIImage(named: "arkaplan")
                                    //                                        self.textField1.text = ""
                                    //                                        self.textField2.text = ""
                                    //                                        self.textField3.text = ""
                                    //                                    }
                                    //                                }
                                    //
                                }
                            }
                        }
                    }
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
}

// MARK: Galeriden fotoğraf seçme kısmı
extension RegisterPage : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func showImagePickerController() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageViewm.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewm.image = originalImage
        }
        dismiss(animated: true)
    }
    
}
