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
    var isSenderDeviceInfo = false
    
    @IBOutlet weak var btnScanBarcode: UIButton!
    @IBOutlet weak var tfAssetTag: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatFields(fields: [tfAssetTag] as! Array<UIView>)
        
        if isSenderDeviceInfo {
            tfAssetTag.isHidden = false
            tfAssetTag.text = barcode
        }
        isSenderDeviceInfo = false
    }
    
    @IBAction func doBtnTypeInAssetTag(_ sender: Any) {
        tfAssetTag.isHidden = false
    }
    
    @IBAction func doTfAssetTag(_ sender: Any) {
        if tfAssetTag.text != "" {
            barcode = tfAssetTag.text
            performSegue(withIdentifier: "toDeviceInfoController", sender: tfAssetTag)
        }
    }
    
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
                // should also cancel the segue at this point
                // cannot recreate this situation currently so will not
                // mess with it for now
            }
        }
        else if segue.identifier == "toDeviceInfoController" {
            let controller = segue.destination as? DeviceInfoController
            controller?.barcode = self.barcode
        }
    }
}
