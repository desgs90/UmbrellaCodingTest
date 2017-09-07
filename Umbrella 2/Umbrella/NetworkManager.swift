//
//  NetworkManager.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    weak var delegate: NetworkManagerDelegate?
    lazy var dayForecast = TodayForecastModuleDAO.instance
    lazy var detaiDayForeast = DetailDayForecastDAO.instance
    
    func getForecastByZipCode(_ zipCode: String) {
        let url = URL(string: helper.networkRequest.forecast.appending(zipCode).appending(".json"))
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any] {
                        //checkResponseError
                        if let responseErrorParent = jsonObject["response"] as? [String: Any] {
                            if let error = responseErrorParent["error"] as? [String: String] {
                                print("Error in the URL:\(error["type"] ?? "error")")
                                return
                            }
                        }
                        //ParseInfo
                        self.dayForecast.parseForecast(jsonObject)
                        DispatchQueue.main.async {
                            self.delegate?.didGetForecast()
                        }
                    }
                } catch {
                
                }
            }
        }
        task.resume()
    }
    
    func getHourlytByZipCode(_ zipCode: String) {
        let url = URL(string: helper.networkRequest.hourly.appending(zipCode).appending(".json"))
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any] {
                        //checkResponseError
                        if let responseErrorParent = jsonObject["response"] as? [String: Any] {
                            if let error = responseErrorParent["error"] as? [String: String] {
                                print("Error in the URL:\(error["type"] ?? "error")")
                                return
                            }
                        }
                        //ParseInfo
                        guard let result = jsonObject["hourly_forecast"] as? [[String:Any]] else { return }
                        self.detaiDayForeast.parseDay(result)
                        DispatchQueue.main.async {
                            self.delegate?.didGetHourly()
                        }
                    }
                } catch {
                    
                }
            }
        }
        task.resume()
    }
}

protocol NetworkManagerDelegate: class {
    
    func didGetForecast()
    func didGetHourly()
    
}
