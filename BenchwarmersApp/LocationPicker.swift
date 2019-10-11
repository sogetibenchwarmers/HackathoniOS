//
//  LocationPicker.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/11/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//
// Ref:
// https://daddycoding.com/2017/07/27/ios-tutorials-pickerview-uialertcontroller/

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class LocationPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var locations: Array<JSON>? = nil
    var pickerView = UIPickerView()
    var selection: String? = nil
    var locationsUrl = "https://hackathon-netcore-api.azurewebsites.net/api/v1/locations"
    
    func getLocations(completion: @escaping () -> Void) {
        Alamofire.request(locationsUrl, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("received locations data")
                self.locations = JSON(response.result.value!)["data"].arrayValue
                completion()
            }
            else {
                print("error getting locations data")
                let json = JSON(response.result.value!)
                self.displayError(
                    errorTitle: json["title"].stringValue,
                    errorMessage: json["detail"].stringValue
                )
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formatLocation(locationJson: locations![row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = locations![row]["id"].stringValue
    }
    
}
