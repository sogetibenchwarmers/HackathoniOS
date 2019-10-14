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
                print("display alert controller at this point")
            }
        }
        else if segue.identifier == "toDeviceInfoController" {
            let controller = segue.destination as? DeviceInfoController
            controller?.barcode = self.barcode
        }
    }
}
