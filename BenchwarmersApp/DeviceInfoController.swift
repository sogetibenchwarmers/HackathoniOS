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
    var deviceDataModel = DeviceDataModel()
    let baseAssetUrl = "https://hackathon-netcore-api.azurewebsites.net/api/v1/assets/"

    @IBOutlet weak var tfAssetTag: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfOwnedBy: UITextView!
    @IBOutlet weak var tfStatus: UITextView!
    @IBOutlet weak var tfSupportGroup: UITextView!
    @IBOutlet weak var tfAssignmentGroup: UITextView!
    @IBOutlet weak var tvSubLocation: UITextView!
    @IBOutlet weak var tvLocation: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("device info controller loading")
        
        let fields = [
            tfAssetTag,
            tfName,
            tfOwnedBy,
            tfStatus,
            tfSupportGroup,
            tfAssignmentGroup,
            tvSubLocation,
            tvLocation
        ]
        formatFields(fields: fields as! Array<UIView>)
        
        // asset tag from ScannerController
        // tfAssetTag.text = self.barcode!
        
        // known asset tag for demo
        let assetTag = "P1000892"
        let assetUrl = baseAssetUrl + assetTag
        Alamofire.request(assetUrl, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("received device data")
                let json = JSON(response.result.value!)
                
                // debug ... location, subLocation, status, ownedBy all null
                // this was supposed to be the asset tag with the most info?
                // double check with Tom
                print(json)
                
                self.updateModel(json: json)
                self.updateUI()
            }
            else {
                print("error getting device data")
                let json = JSON(response.result.value!)
                self.displayError(
                    errorTitle: json["title"].stringValue,
                    errorMessage: json["detail"].stringValue
                )
            }
        }
        
    }
    
     func updateModel(json: JSON) {
        deviceDataModel.id = json["id"].stringValue
        deviceDataModel.assetTag = json["assetTag"].stringValue
        deviceDataModel.name = json["name"].stringValue
        deviceDataModel.ownedBy = json["ownedBy"].stringValue
        deviceDataModel.location = formatLocation(locationJson: json["location"])
        deviceDataModel.locationId = json["location"]["id"].stringValue
        deviceDataModel.subLocation = formatLocation(locationJson: json["subLocation"])
        deviceDataModel.subLocationId = json["subLocation"]["id"].stringValue
        deviceDataModel.status = json["status"].stringValue
        deviceDataModel.supportGroup = json["supportGroup"]["name"].stringValue
        deviceDataModel.supportGroupId = json["supportGroup"]["id"].stringValue
        deviceDataModel.assignmentGroup = json["assignmentGroup"].stringValue
     }

    func updateUI() {
        tfAssetTag.text = deviceDataModel.assetTag
        tfName.text = deviceDataModel.name
        tfOwnedBy.text = deviceDataModel.ownedBy
        tfStatus.text = deviceDataModel.status
        tfSupportGroup.text = deviceDataModel.supportGroup
        tfAssignmentGroup.text = deviceDataModel.assignmentGroup
        tvSubLocation.text = deviceDataModel.subLocation
        tvLocation.text = deviceDataModel.location
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDeviceEditController" {
            let controller = segue.destination as? DeviceEditController
            controller?.deviceDataModel = self.deviceDataModel
        }
    
    }
    
}

