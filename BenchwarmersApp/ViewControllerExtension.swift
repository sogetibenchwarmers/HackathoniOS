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
    
    func displayError(errorTitle: String, errorMessage: String, controller: UIViewController, action: @escaping () -> Void = {}) {
        
        let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
        
        let titleColor:[NSAttributedString.Key : AnyObject] = [ NSAttributedString.Key.foregroundColor : UIColor(red: 0.92, green: 0.04, blue: 0.10, alpha: 1.0) ]
        let attributedTitle = NSMutableAttributedString(string: errorTitle, attributes: titleColor)
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in action()})
        okAction.setValue(UIColor.darkText, forKey: "titleTextColor")
        
        alert.addAction(okAction)
        controller.present(alert, animated: true)
    }
}
