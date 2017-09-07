//
//  TodayForecastModuleDAO.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation
import UIKit

class TodayForecastModuleDAO: NSObject {
    public static let instance = TodayForecastModuleDAO()
    
    var todayForecast: TodayForecastModule?
    

    func parseForecast(_ data: [String: Any]) {
        //parseData for weather
        guard let results = data["forecast"] as? [String: Any] else { return }
        guard let simple = results["simpleforecast"] as? [String: Any] else {return}
        guard let forecastDay = simple["forecastday"] as? [Any] else {return}
        
        let today = forecastDay[0] as? [String:Any]
        let lowParent = today?["low"] as? [String:String]
        let low = lowParent?["fahrenheit"]
        
        let highParent = today?["high"] as? [String:String]
        let high = highParent?["fahrenheit"]
        let status = today?["conditions"] as? String
        
        let icon = today?["icon"] as? String
        
        //parse data for city
        guard let cityObs = data["current_observation"] as? [String: Any] else { return }
        guard let citydata = cityObs["display_location"] as? [String: Any] else { return }
        
        let city = citydata["full"] as? String
        
        let newDay = TodayForecastModule(cityName: city!, imgUrl: icon!, minTemp: low!, maxTemp: high!, conditions: status!)
        todayForecast = newDay
        
    }
}
