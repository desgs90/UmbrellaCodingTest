//
//  DetailDayForecastDAO.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation

class DetailDayForecastDAO: NSObject {
    
    public static let instance = DetailDayForecastDAO()
    public var masterDays = [String: [DetailHourForecastModel]]()
    
    public func parseDay(_ data: [[String: Any]]) {
        var hours = [DetailHourForecastModel]()
        var days = [String]()
        for item in data {
            guard let time = item["FCTTIME"] as? [String: Any] else { return }
            let weekDay = time["weekday_name"] as? String ?? ""
            let dayTime = time["civil"] as? String ?? ""
            
            guard let tempParent = item["temp"] as? [String: Any] else { return }
            let temp = tempParent["english"] as? String ?? ""
            let img = item["icon"] as? String ?? ""
            
            let hourDetail = DetailHourForecastModel(time: dayTime, temp: temp, img: img, weekDay: weekDay)
            hours.append(hourDetail)
            if !(days.contains(weekDay)) {
                days.append(weekDay)
            }
        }
        
        for day in days {
            var tempHour = [DetailHourForecastModel]()
            for hour in hours {
                if hour.weekDay == day {
                    tempHour.append(hour)
                }
            }
            masterDays[day] = tempHour
        }
    }    
}
