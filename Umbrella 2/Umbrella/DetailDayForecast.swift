//
//  DetailDayForecast.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation

class DetailDayForecast: NSObject {
    public var name: String
    public var dayNum: Int
    public var hours = [DetailHourForecastModel]()
    
    public init(name: String, dayNum: Int, hours:[DetailHourForecastModel]) {
        self.name = name
        self.dayNum = dayNum
        self.hours = hours
    }
    
}
