//
//  LocationPicker.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/11/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//
//  Ref:
//  https://daddycoding.com/2017/07/27/ios-tutorials-pickerview-uialertcontroller/

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class LocationPicker: BenchwarmersPicker {
    
    var locations: Array<JSON>? = nil
    var pickerView = UIPickerView()
    var locationsUrl = "https://hackathon-netcore-api.azurewebsites.net/api/v1/locations"
    
    func getLocations(controller: UIViewController, completion: @escaping () -> Void) {
        Alamofire.request(locationsUrl, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("received locations data")
                self.locations = JSON(response.result.value!)["data"].arrayValue
                self.selection = self.locations![0]
                completion()
            }
            else {
                self.displayError(
                    errorTitle: "Location Listing Error",
                    errorMessage: "Unable to show location listing at this time due to an unknown error.",
                    controller: controller
                )
            }
        }
    }
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations![row]["name"].stringValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = locations![row]
    }
    
}
