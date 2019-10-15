//
//  AlertController.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/10/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {

    func displayError(errorTitle: String, errorMessage: String, controller: UIViewController) {

        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alert, animated: true)
    }
}
