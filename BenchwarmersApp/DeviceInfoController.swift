//
//  DeviceInfoController.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 9/28/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//

import UIKit

class DeviceInfoController: UIViewController {
    var barcode: String?
    
    @IBOutlet weak var tfAssetTag: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("device info controller loading")
        tfAssetTag.text = self.barcode
    }
    
}
