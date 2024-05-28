//
//  Singleton.swift
//  FoursquareClone
//
//  Created by Özcan on 28.05.2024.
//

import Foundation

class Singleton {
    
    static let sharedObject = Singleton()
    
    var name = String()
    var type = String()
    var comment = String()
    var latitude = Double()
    var longitude = Double()
    
    private init() {}
    
}
