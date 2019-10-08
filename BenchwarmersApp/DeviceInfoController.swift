//
//  DeviceInfoController.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 9/28/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DeviceInfoController: UIViewController {
    
    //Constants
    var barcode: String?
    
    @IBOutlet weak var tfAssetTag: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfOwnedBy: UITextField!
    @IBOutlet weak var tfStatus: UITextField!
    @IBOutlet weak var tfSupportGroup: UITextField!
    @IBOutlet weak var tfAssignmentGroup: UITextField!
    @IBOutlet weak var tvSubLocation: UITextView!
    @IBOutlet weak var tvLocation: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("device info controller loading")
        
        let fields = [
            self.tfAssetTag!,
            self.tfName!,
            self.tfOwnedBy!,
            self.tfStatus!,
            self.tfSupportGroup!,
            self.tfAssignmentGroup!,
            self.tvSubLocation!,
            self.tvLocation!
        ]
        
        for field in fields {
            field.layer.borderWidth = 2
            field.layer.borderColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0).cgColor
            field.layer.cornerRadius = 5
            field.clipsToBounds = true
        }
        
        tfAssetTag.text = self.barcode
        
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
}
