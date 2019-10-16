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
import SVProgressHUD

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

        // known asset tag for demo
        // "P1000892"
        
        // just in case assetTag doesn't come in the GET request
        // ensure it is in the model since we force unwrap in
        // DeviceEditController
        deviceDataModel.assetTag = self.barcode!
        
        let assetUrl = baseAssetUrl + self.barcode!
        
        SVProgressHUD.show(withStatus: "Loading...")
        Alamofire.request(assetUrl, method: .get).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                print("received device data")
                let json = JSON(response.result.value!)
                self.updateModel(json: json)
                self.updateUI()
            } else if response.response?.statusCode == 404 {
                self.displayError(
                    errorTitle: "Device Viewing Error",
                    errorMessage: "This asset tag is not associated with any devices.",
                    controller: self,
                    action: {() in self.performSegue(withIdentifier: "toHomeControllerBcError", sender: self)}
                )
            }
            else {
                self.displayError(
                    errorTitle: "Device Viewing Error",
                    errorMessage: "Unable to view device info at this time due to an unknown error.",
                    controller: self,
                    action: {() in self.performSegue(withIdentifier: "toHomeControllerBcError", sender: self)}
                )
                
            }
            SVProgressHUD.dismiss()
        }
        
    }
    
     func updateModel(json: JSON) {
        deviceDataModel.id = json["id"].string
        deviceDataModel.assetTag = json["assetTag"].string
        deviceDataModel.name = json["name"].string
        deviceDataModel.ownedBy = json["ownedBy"]["name"].string
        deviceDataModel.ownedById = json["ownedBy"]["id"].string
        deviceDataModel.location = json["location"]["name"].string
        deviceDataModel.locationId = json["location"]["id"].string
        deviceDataModel.subLocation = json["subLocation"]["name"].string
        deviceDataModel.subLocationId = json["subLocation"]["id"].string
        deviceDataModel.status = json["status"].string
        deviceDataModel.supportGroup = json["supportGroup"]["name"].string
        deviceDataModel.supportGroupId = json["supportGroup"]["id"].string
        deviceDataModel.assignmentGroup = json["assignmentGroup"].string
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
        if segue.identifier == "toHomeControllerBcError" {
            let controller = segue.destination as? HomeController
            controller?.isSenderDeviceInfo = true
            controller?.barcode = barcode
        }
    
    }
    
}

