//
//  ForecastDetailCell.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import UIKit

class ForecastDetailCell: UICollectionViewCell {
    //MARK:- IBOUtlets
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastTime: UILabel!
    @IBOutlet weak var forecastTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
