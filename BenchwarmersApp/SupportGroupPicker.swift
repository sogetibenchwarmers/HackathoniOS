//
//  SupportGroupPicker.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/13/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//
//  Ref:
//  https://daddycoding.com/2017/07/27/ios-tutorials-pickerview-uialertcontroller/

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class SupportGroupPicker: BenchwarmersPicker  {
    
    var supportGroups: Array<JSON>? = nil
    var pickerView = UIPickerView()
    var supportGroupsUrl = "https://hackathon-netcore-api.azurewebsites.net/api/v1/groups"
    
    func getSupportGroups(controller: UIViewController, completion: @escaping () -> Void) {
        Alamofire.request(supportGroupsUrl, method: .get).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                print("received support groups data")
                self.supportGroups = JSON(response.result.value!)["data"].arrayValue
                self.selection = self.supportGroups![0]
                completion()
            }
            else {
                self.displayError(
                    errorTitle: "Support Group Listing Error",
                    errorMessage: "Unable to show support group listing at this time due to an unknown error.",
                    controller: controller
                )
            }
        }
    }
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return supportGroups!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return supportGroups![row]["name"].stringValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = supportGroups![row]
    }
    
}
