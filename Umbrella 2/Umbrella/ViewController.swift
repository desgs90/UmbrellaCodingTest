//
//  ViewController.swift
//  Umbrella
//
//  Created by Diego Eduardo on 9/7/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var forecastView: ForecastView!
    @IBOutlet weak var searchZipCode: UIButton!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Public Var
    var locManager = CLLocationManager()
    var networkManager = NetworkManager()
    lazy var dayForecast = TodayForecastModuleDAO.instance
    lazy var hourForecast  = DetailDayForecastDAO.instance
    

    var dayDetails = [String: [DetailHourForecastModel]]()
    
    //MARK:- LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        locManager.delegate = self
        zipCode.delegate = self
        locManager.requestWhenInUseAuthorization()
        collectionSetUp()
        
        if let savedZipCode = helper.getZipCode() {
            zipCode.text = savedZipCode
            networkManager.getForecastByZipCode(savedZipCode)
            networkManager.getHourlytByZipCode(savedZipCode)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //MARK:- UIButtonActions
    
    @IBAction func searchZipCode(_ sender: UIButton) {
        if !validateZipCode() {
            //perform error for Zip Code
            return
        }
        helper.setZipCode(zipCode.text!)
        launcSearchForecast()
        //Action to handle a valid ZipCode
    }
    //MARK:-
    //MARK: PrivateMethods
    
    //MARK:- CollectionSetUp
    fileprivate func collectionSetUp() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        
        let headerNib = UINib(nibName: "CollectionHeaderView", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        
        let cellNib = UINib(nibName: "ForecastDetailCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "ForecastDetailCell")
    }
    
    //MARK:- ValidateZipCode
    fileprivate func validateZipCode()-> Bool {
        view.endEditing(true)
        let code = zipCode.text
        var result = false
        result = code?.characters.count != 5 ? false:true
        return result
    }
    
    fileprivate func setLocation() {
        
        print("Lat = \(String(describing: locManager.location?.coordinate.latitude)), Long = \(String(describing: locManager.location?.coordinate.longitude))")
    }
    
    fileprivate func updateForecastView() {
        forecastView.updateView(self.dayForecast.todayForecast!)
    }
    
    fileprivate func launcSearchForecast() {
        if let savedZipCode = helper.getZipCode() {
            zipCode.text = savedZipCode
            networkManager.getForecastByZipCode(savedZipCode)
            networkManager.getHourlytByZipCode(savedZipCode)
        }
    }
    
    fileprivate func updateCollectionView() {
        dayDetails = hourForecast.masterDays
        self.collectionView.reloadData()
    }
}

//MARK:- Collection delegate and DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastDetailCell", for: indexPath) as! ForecastDetailCell
        
        let key = Array(dayDetails.keys)[indexPath.section]
        let items = dayDetails[key]
        let item = items?[indexPath.item]
        
        cell.forecastTemp.text = item?.temp.appending("˚F")
        cell.forecastTime.text = item?.time
        cell.forecastImage.image = UIImage(named: (item?.img)!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as! CollectionHeaderView
            
            if indexPath.section == 0 {
                header.title.text = "Today"
            } else if indexPath.section == 1 {
                header.title.text = "Tomorrow"
            } else {
                let title = Array(dayDetails.keys)[indexPath.section]
                header.title.text = title
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dayDetails.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = Array(dayDetails.keys)[section]
        let items = dayDetails[key]?.count ?? 0
        return items
    }
}

//MARK:- Location
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                    setLocation()
                }
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Add done button to numeric pad keyboard
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: .done,
                                              target: self, action: #selector(ViewController.doneButton_Clicked(_:)))
        
        toolbarDone.items = [barBtnDone] // You can even add cancel button too
        zipCode.inputAccessoryView = toolbarDone
    }
    @objc fileprivate func doneButton_Clicked(_ sender: UIButton) {
        if !validateZipCode() {
            //perform error for Zip Code
            return
        }
        helper.setZipCode(zipCode.text!)
        launcSearchForecast()
        //Action to handle a valid ZipCode
    }
}

//MARK:- Delegate Networking

extension ViewController: NetworkManagerDelegate {
    func didGetForecast() {
        updateForecastView()
    }
    func didGetHourly() {
        self.updateCollectionView()
    }
}


