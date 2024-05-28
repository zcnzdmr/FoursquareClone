//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//


import UIKit
import FirebaseAuth

class SignInPage: UIViewController {
    
    var titleLabel = UILabel()
    var emailTF = UITextField()
    var passwordTF = UITextField()
    var signInButon = UIButton()
    var signUpButon = UIButton()
    var viewImage = UIImageView()
    var viewModelNesnesi = SignInVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUIS()
//        currentUserFonk()
    }
    
    //
    override func viewWillAppear(_ animated: Bool) {
        
        // Burda sayfanın geri butonunu gizledik.
//        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
//        func currentUserFonk() {
//            let currentUser = Auth.auth().currentUser
//            if currentUser != nil {
//                self.navigationController?.pushViewController(HomePage(), animated: true)
//            }
//        }
    
    private func setUpUIS() {
        
        let screenWidth = view.frame.size.width
        
        // MARK: BackBar Button Item oluşturma kısmı
        let logOut = UIBarButtonItem()
        logOut.tintColor = .black
        logOut.title = "Log Out"
        self.navigationItem.backBarButtonItem = logOut

        viewImage.frame = view.bounds
        viewImage.image = UIImage(named: "bart")
        view.addSubview(viewImage)
        
        titleLabel.frame = CGRect(x: 10, y: 100, width: (screenWidth - 20), height: 70)
        titleLabel.text = "Foursquare Clone 📍"
        titleLabel.font  = UIFont(name: "Arial", size: 30)
        titleLabel.textColor = .black
        titleLabel.layer.borderWidth = 0.7
        titleLabel.layer.cornerRadius = 6
        titleLabel.clipsToBounds = true
        titleLabel.backgroundColor = .systemYellow
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        emailTF.frame = CGRect(x: 20, y: 240, width: screenWidth - 40, height: 45)
        emailTF.placeholder = "Enter your email"
        emailTF.borderStyle = UITextField.BorderStyle.roundedRect
        emailTF.layer.borderWidth = 0.6
        view.addSubview(emailTF)
        
        passwordTF.frame = CGRect(x: 20, y: 300, width: screenWidth - 40, height: 45)
        passwordTF.placeholder = "Enter your password"
        passwordTF.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTF.layer.borderWidth = 0.6
        view.addSubview(passwordTF)
        
        signInButon.frame = CGRect(x: 35, y: 390, width: 120, height: 50)
        signInButon.setTitle("Sign in", for: UIControl.State.normal)
        signInButon.setTitleColor(UIColor.black, for: UIControl.State.normal)
        signInButon.backgroundColor = .systemYellow
        signInButon.layer.borderWidth = 1
        signInButon.layer.cornerRadius = 10
        signInButon.addTarget(self, action: #selector(signInFonk), for: UIControl.Event.touchUpInside)
        view.addSubview(signInButon)
        
        signUpButon.frame = CGRect(x: (screenWidth - 155), y: 390, width: 120, height: 50)
        signUpButon.setTitle("Sign up", for: UIControl.State.normal)
        signUpButon.setTitleColor(UIColor.black, for: UIControl.State.normal)
        signUpButon.backgroundColor = .systemYellow
        signUpButon.layer.borderWidth = 1
        signUpButon.layer.cornerRadius = 10
        signUpButon.addTarget(self, action: #selector(signUpFonk), for: UIControl.Event.touchUpInside)
        view.addSubview(signUpButon)
        
    }
    
    
    @objc func signInFonk() {
        
        if emailTF.text != "" && passwordTF.text != "" {
            if let email = emailTF.text , let password = passwordTF.text {
                Auth.auth().signIn(withEmail: email , password: password) { authdata, error in
                    if error != nil {
                        self.alert(title: "Error", message: error?.localizedDescription ?? "Username or Password isnt correct")
                    }else{
                        self.show(HomePage(), sender: nil)
                    }
                }
                
            }
            
        }else{
            alert(title: "Error", message: "Username or Password not entered")
        }
    }
    
    @objc func signUpFonk() {
        
        if emailTF.text != "" && passwordTF.text != "" {
            
            if let email = emailTF.text , let password = passwordTF.text {
                
                Auth.auth().createUser(withEmail: email, password: password) { authdata, error in
                    
                    if error != nil {
                        print(error?.localizedDescription ?? "Error")
                    }else{
                        self.navigationController?.pushViewController(HomePage(), animated: true)
                    }
                }
            }
        }else{
            alert(title: "Error", message: "User name/password not entered")
        }
    }
    
        
    
    func alert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        self.present(alert,animated: true)
        
    }
}


