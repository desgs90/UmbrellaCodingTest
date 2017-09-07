//
//  ForecastView.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import UIKit

class ForecastView: UIView {

    //MARK:- IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    
    fileprivate func setUp() {
        Bundle.main.loadNibNamed("ForecastView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    public func updateView(_ forecastDay: TodayForecastModule) {
        cityName.text = forecastDay.cityName
        tempMax.text = forecastDay.maxTemp.appending("˚F")
        tempMin.text = forecastDay.minTemp.appending("˚F")
        condition.text = forecastDay.conditions
        weatherIcon.image = UIImage(named: forecastDay.imgUrl)
    }
}
