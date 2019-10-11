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

class DeviceController: UIViewController {
    
    func formatFields(fields: Array<UIView>) {
        for field in fields {
            field.layer.borderWidth = 2
            field.layer.borderColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0).cgColor
            field.layer.cornerRadius = 5
            field.clipsToBounds = true
        }
    }
    
    func formatLocation(locationJson: JSON) -> String {
        return locationJson["name"].stringValue +
            "\n" + locationJson["street"].stringValue +
            "\n" + locationJson["city"].stringValue +
            ", " + locationJson["state"].stringValue +
            ", " + locationJson["zip"].stringValue +
            "\n" + locationJson["country"].stringValue
    }
}
