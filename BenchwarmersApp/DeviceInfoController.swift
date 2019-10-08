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
    
    var barcode: String?
    let url = "https://learnappmaking.com/ex/users.json"
    
    
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
        
        // Get Request
        Alamofire.request(url, method: .get).responseJSON {
                response in
                if response.result.isSuccess {
                    print("Success! Got the data")
                    
                    let json : JSON = JSON(response.result.value!)
                    print(json)
                  self.updateData(json: json)
                }
                else {
                    print("Error \(response.result.error)")
        //                    self.cityLabel.text = "Connection Issues"
                    
                }
            }
        
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getData method here:
      func getData(url: String, parameters: [String : String]){
            
            
            
        }
    
    //MARK: - JSON Parsing
     /***************************************************************/
    
     
     //Write the updateWeatherData method here:
     func updateData(json : JSON) {
         
        let tempResult = json[0]["age"]
        print(tempResult)
         
     }
    
}
