//
//  DepartmentPicker.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/16/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//
//  Ref:
//  https://daddycoding.com/2017/07/27/ios-tutorials-pickerview-uialertcontroller/

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class DepartmentPicker: BenchwarmersPicker {
    
    var departments: Array<JSON>? = nil
    var pickerView = UIPickerView()
    var departmentsUrl = "https://hackathon-netcore-api.azurewebsites.net/api/v1/subLocations"
    
    func getDepartments(controller: UIViewController, completion: @escaping () -> Void) {
        Alamofire.request(departmentsUrl, method: .get).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                print("received departments data")
                self.departments = JSON(response.result.value!)["data"].arrayValue
                self.selection = self.departments![0]
                completion()
            }
            else {
                self.displayError(
                    errorTitle: "Department Listing Error",
                    errorMessage: "Unable to show department listing at this time due to an unknown error.",
                    controller: controller
                )
            }
        }
    }
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departments![row]["name"].stringValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = departments![row]
    }
}
