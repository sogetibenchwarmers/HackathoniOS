//
//  HomeController.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 9/28/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var barcode: String?
    
    @IBOutlet weak var btnScanBarcode: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toScannerController" {
            let controller = segue.destination as? ScannerController
            controller?.barcodeScanned = { (code: String) in
                self.barcode = code
                self.performSegue(withIdentifier: "toDeviceInfoController", sender: nil)
            }
            controller?.barcodeNotFound = {
                self.displayError(
                    errorTitle: "Barcode Scanning Error",
                    errorMessage: "Unable to scan barcode at this time due to an unknown error.",
                    controller: self
                )
            }
        }
        else if segue.identifier == "toDeviceInfoController" {
            let controller = segue.destination as? DeviceInfoController
            controller?.barcode = self.barcode
        }
    }
}
