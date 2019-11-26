//
//  OwnedByPicker.swift
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

class OwnedByPicker: BenchwarmersPicker {
    
    var users: Array<JSON>? = nil
    var pickerView = UIPickerView()
    var usersUrl = "https://hackathon-netcore-api.azurewebsites.net/api/v1/users"
    
    func getUsers(controller: UIViewController, completion: @escaping () -> Void) {
        Alamofire.request(usersUrl, method: .get).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                print("received users data")
                self.users = JSON(response.result.value!)["data"].arrayValue
                self.selection = self.users![0]
                completion()
            }
            else {
                self.displayError(
                    errorTitle: "Users Listing Error",
                    errorMessage: "Unable to show users listing at this time due to an unknown error.",
                    controller: controller
                )
            }
        }
    }
    
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users![row]["name"].stringValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selection = users![row]
    }
}
