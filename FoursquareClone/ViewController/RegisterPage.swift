//
//  RegisterPage.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit

class RegisterPage: UIViewController {
    
    var imageViewm = UIImageView()
    var textField1 = UITextField()
    var textField2 = UITextField()
    var textField3 = UITextField()
    var nextButton = UIButton()


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
        
        textField2.frame = CGRect(x: 5, y: 495, width: (screenWidth - 10), height: 40)
        textField2.layer.borderWidth = 0.7
        textField2.placeholder = "Enter the type of place"
        view.addSubview(textField2)
        
        textField3.frame = CGRect(x: 5, y: 540, width: (screenWidth - 10), height: 40)
        textField3.layer.borderWidth = 0.7
        textField3.placeholder = "Enter the attribute of place"
        view.addSubview(textField3)
        
        nextButton.frame = CGRect(x: (screenWidth - 80) / 2 , y: 600, width: 80, height: 100)
        nextButton.setImage(UIImage(systemName: "arrowshape.right"), for: UIControl.State.normal)
        nextButton.tintColor = .black
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(passToMapVM), for: UIControl.Event.touchUpInside)
        view.addSubview(nextButton)
        
//        NSLayoutConstraint.activate([
//            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
//            nextButton.widthAnchor.constraint(equalToConstant: 80),
//            nextButton.heightAnchor.constraint(equalToConstant: 100)
//                ])
    }
    
    @objc func passToMapVM() {
        self.navigationController?.pushViewController(MapPage(), animated: true)
    }
    
    func tapGesture() {
        imageViewm.isUserInteractionEnabled = true
        let gR = UITapGestureRecognizer(target: self, action: #selector(showImagePickerController))
        imageViewm.addGestureRecognizer(gR)
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
        }
        dismiss(animated: true)
    }
}
