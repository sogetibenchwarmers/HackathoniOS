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

    @IBOutlet weak var tvAssetTag: UITextView!
    @IBOutlet weak var tvName: UITextView!
    @IBOutlet weak var tvOwnedBy: UITextView!
    @IBOutlet weak var tvStatus: UITextView!
    @IBOutlet weak var tvSupportGroup: UITextView!
    @IBOutlet weak var tvAssignmentGroup: UITextView!
    @IBOutlet weak var tvSubLocation: UITextView!
    @IBOutlet weak var tvLocation: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("device info controller loading")
        
        let fields = [
            tvAssetTag,
            tvName,
            tvOwnedBy,
            tvStatus,
            tvSupportGroup,
            tvAssignmentGroup,
            tvSubLocation,
            tvLocation
        ]
        formatFields(fields: fields as! Array<UIView>)
        
        // asset tag from ScannerController
        // tvAssetTag.text = self.barcode!
        
        // known asset tag for demo
        let assetTag = "P1000892"
        let assetUrl = baseAssetUrl + assetTag
        Alamofire.request(assetUrl, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("received device data")
                let json = JSON(response.result.value!)
                self.updateModel(json: json)
                self.updateUI()
            }
            else {
                self.displayError(
                    errorTitle: "Device Viewing Error",
                    errorMessage: "Unable to view device info at this time due to an unknown error.",
                    controller: self
                )
            }
        }
        
    }
    
     func updateModel(json: JSON) {
        deviceDataModel.id = json["id"].stringValue
        deviceDataModel.assetTag = json["assetTag"].stringValue
        deviceDataModel.name = json["name"].stringValue
        deviceDataModel.ownedBy = json["ownedBy"]["name"].stringValue
        deviceDataModel.ownedById = json["ownedBy"]["id"].stringValue
        deviceDataModel.location = json["location"]["name"].stringValue
        deviceDataModel.locationId = json["location"]["id"].stringValue
        deviceDataModel.subLocation = json["subLocation"]["name"].stringValue
        deviceDataModel.subLocationId = json["subLocation"]["id"].stringValue
        deviceDataModel.status = json["status"].stringValue
        deviceDataModel.supportGroup = json["supportGroup"]["name"].stringValue
        deviceDataModel.supportGroupId = json["supportGroup"]["id"].stringValue
        deviceDataModel.assignmentGroup = json["assignmentGroup"].stringValue
     }

    func updateUI() {
        tvAssetTag.text = deviceDataModel.assetTag
        tvName.text = deviceDataModel.name
        tvOwnedBy.text = deviceDataModel.ownedBy
        tvStatus.text = deviceDataModel.status
        tvSupportGroup.text = deviceDataModel.supportGroup
        tvAssignmentGroup.text = deviceDataModel.assignmentGroup
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

