//
//  AppDelegate.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav1 = UINavigationController()
        
        let mainView = SignInPage(nibName: nil, bundle: nil)
        let mainView2 = HomePage(nibName: nil, bundle: nil)
        
        // MARK: Kullanici kaydedip yönlendirme kısmı
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            nav1.viewControllers = [mainView2]
            self.window?.rootViewController = nav1
        }else{
            nav1.viewControllers = [mainView]
            self.window?.rootViewController = nav1
        }
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
}


