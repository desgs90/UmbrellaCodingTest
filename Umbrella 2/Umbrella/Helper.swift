//
//  Helper.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation

class helper: NSObject {

fileprivate static let userDefaults = UserDefaults.standard
    fileprivate static let api = "d06ecc9977b26e06"
    
    
    struct networkRequest {
        static let hourly = "https://api.wunderground.com/api/" + api + "/hourly/q/"
        static let forecast = "https://api.wunderground.com/api/" + api + "/conditions/forecast/q/"
    }
    
    static func getZipCode() -> String?{
        let zipCode = userDefaults.string(forKey: "ZipCode")
        return zipCode != nil ? zipCode! : nil
    }
    
    static func setZipCode(_ zip: String) {
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: zip)) &&
            zip.characters.count == 5 {
            userDefaults.set(zip, forKey: "ZipCode")
            userDefaults.synchronize()
        }
    }
    
    
}
