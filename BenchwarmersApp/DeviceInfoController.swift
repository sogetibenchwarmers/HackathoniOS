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
    let deviceDataModel = DeviceDataModel()
    
    
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
//      func getData(url: String, parameters: [String : String]){
//
//
//
//        }
    
    //MARK: - JSON Parsing
     /***************************************************************/
    
     
     //Write the updateWeatherData method here:
     func updateData(json : JSON) {
        
        // if results of age are nil, block won't execute.
        // Needed so we don't have to force unwrapping of data,
        // which could cause an error if no data came
        if let ageResult = json[0]["age"].int {
//        let lastNameResult = json[0]["last_name"].stringValue
//        print(lastNameResult)
        deviceDataModel.age = ageResult
        deviceDataModel.lastName = json[0]["last_name"].stringValue
            
        updateUIWithDeviceData()
        }
        else {
//            cityLabel.text = "Not Found"
        }
         
     }
    
    //MARK: - UI Updates
     /***************************************************************/
    func updateUIWithDeviceData() {
        tfName.text = deviceDataModel.lastName
        tfAssetTag.text = deviceDataModel.lastName
        //if data is int, need to convert to string
        tfOwnedBy.text = "\(deviceDataModel.age)"
        tfStatus.text = deviceDataModel.lastName
        tfSupportGroup.text = deviceDataModel.lastName
        tfAssignmentGroup.text = deviceDataModel.lastName
        tvSubLocation.text = deviceDataModel.lastName
        tvLocation.text = deviceDataModel.lastName
    }
    
}

