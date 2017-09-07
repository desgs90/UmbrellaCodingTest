//
//  TodayForecastModule.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation
import UIKit

class TodayForecastModule: NSObject {
    
    //https://api.wunderground.com/api/d06ecc9977b26e06/forecast/q/30080.json
    //https://maps.googleapis.com/maps/api/geocode/json?latlng=33.8907535,-84.4801484
    //https://api.wunderground.com/api/d06ecc9977b26e06/forecast/q/30080.json
    
    
    public var cityName: String
    public var imgUrl: String
    public var minTemp: String
    public var maxTemp: String
    public var conditions: String
    
    public init(cityName: String, imgUrl: String, minTemp: String, maxTemp:String,conditions: String) {
        self.cityName = cityName
        self.imgUrl = imgUrl
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.conditions = conditions
    }
}
