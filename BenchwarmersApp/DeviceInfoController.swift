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
    let deviceDataModel = DeviceDataModel()
    let url = "https://hackathon-netcore-api.azurewebsites.net/api/v1/assets/"
    
    
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
        
        // GET Request
        
//        let assetId = self.barcode!
        let assetId = "P0001"
        var newURL = url + assetId
        Alamofire.request(newURL, method: .get).responseJSON {
                response in
                if response.result.isSuccess {
                    print("Success! Got the data")
                    
                    let json : JSON = JSON(response.result.value!)
                    self.updateData(json: json)
                }
                else {
                    print("Error \(response.result.error)")
        //          TO DO: Display errors in UI
                    
                }
            }
        
    }
    
    
    //MARK: - JSON Parsing
     /***************************************************************/
    
     
     func updateData(json : JSON) {
        
        // if results of age are nil, block won't execute.
        // Needed so we don't have to force unwrapping of data,
        // which could cause an error if no data came
        if let id = json["id"].string {
            print(json)
        deviceDataModel.name = json["name"].stringValue
        deviceDataModel.ownedBy = json["ownedBy"].stringValue
        deviceDataModel.status = json["status"].stringValue
        deviceDataModel.supportGroup = json["supportGroup"].stringValue
        deviceDataModel.assignmentGroup = json["assignmentGroup"].stringValue
        deviceDataModel.subLocation = json["subLocation"].stringValue
        deviceDataModel.locationName = json["location"]["name"].stringValue
        deviceDataModel.locationStreet = json["location"]["street"].stringValue
        deviceDataModel.locationCity = json["location"]["city"].stringValue
        deviceDataModel.locationState = json["location"]["state"].stringValue
        deviceDataModel.locationStreet = json["location"]["street"].stringValue
        deviceDataModel.locationZip = json["location"]["zip"].stringValue
        deviceDataModel.locationCountry = json["location"]["Country"].stringValue
            
        updateUIWithDeviceData()
            
        }
        else {
            print("No ID found")
//          TO DO - Add into UI
        }
         
     }
    
    //MARK: - UI Updates
     /***************************************************************/
    func updateUIWithDeviceData() {
        tfName.text = deviceDataModel.name
        tfOwnedBy.text = deviceDataModel.ownedBy
        tfStatus.text = deviceDataModel.status
        tfSupportGroup.text = deviceDataModel.supportGroup
        tfAssignmentGroup.text = deviceDataModel.assignmentGroup
        tvSubLocation.text = deviceDataModel.subLocation
        tvLocation.text = deviceDataModel.locationName
    }
    
}

