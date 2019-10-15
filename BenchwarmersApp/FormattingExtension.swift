//
//  DeviceController.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/11/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension UIViewController {
    
    func formatFields(fields: Array<UIView>) {
        for field in fields {
            field.layer.borderWidth = 2
            field.layer.borderColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0).cgColor
            field.layer.cornerRadius = 5
            field.clipsToBounds = true
        }
    }
    
    func formatLocation(locationJson: JSON) -> String {
        var formattedLocation = ""
        
        if let street = locationJson["street"].string {
            formattedLocation += street + "\n"
        }
        
        var newLine = false;
        
        var citySet = false
        if let city = locationJson["city"].string {
            formattedLocation += city
            citySet = true
            newLine = true
        }
        
        var stateSet = false
        if let state = locationJson["state"].string {
            if citySet {
                formattedLocation += ", " + state
            } else {
                formattedLocation += state
            }
            stateSet = true
            newLine = true
        }
        
        if let zip = locationJson["zip"].string {
            if citySet || stateSet {
                formattedLocation += ", " + zip
            } else {
                formattedLocation += zip
            }
            newLine = true
        }
        
        if let country = locationJson["country"].string {
            if newLine {
                formattedLocation += "\n" + country
            } else {
                formattedLocation += country
            }
        }
        
        return formattedLocation
    }
}
