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
    
    func displayError(errorTitle: String, errorMessage: String, controller: UIViewController) {
        
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alert, animated: true)
    }
}
