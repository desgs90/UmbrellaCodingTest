//
//  DetailHourForecastModel.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation

class DetailHourForecastModel: NSObject {
    
    public var time: String
    public var temp: String
    public var img: String
    public var weekDay: String
    
    public init(time: String, temp: String, img: String, weekDay: String) {
        self.time = time
        self.temp = temp
        self.img = img
        self.weekDay = weekDay
    }
}
