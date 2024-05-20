//
//  AppDelegate.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav1 = UINavigationController()
        let mainView = SignInPage(nibName: nil, bundle: nil)
        nav1.viewControllers = [mainView]
        self.window?.rootViewController = nav1
        self.window?.makeKeyAndVisible()
        
        return true
    }
}


