//
//  DeviceEditController.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/11/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON

class DeviceEditController: DeviceController {
    
    var deviceDataModel: DeviceDataModel?
    
    @IBOutlet weak var tfAssetTag: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfOwnedBy: UITextField!
    @IBOutlet weak var tvLocation: UITextView!
    @IBOutlet weak var tvSubLocation: UITextView!
    @IBOutlet weak var tfStatus: UITextField!
    @IBOutlet weak var tfSupportGroup: UITextField!
    @IBOutlet weak var tfAssignmentGroup: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("device edit controller loading")
        
        let fields = [
            tfAssetTag,
            tfName,
            tfOwnedBy,
            tfStatus,
            tfSupportGroup,
            tfAssignmentGroup,
            tvSubLocation,
            tvLocation!
        ]
        formatFields(fields: fields as! Array<UIView>)
        updateUI()
    }
    
    func updateUI() {
        tfAssetTag.text = deviceDataModel?.assetTag
        tfName.text = deviceDataModel?.name
        tfOwnedBy.text = deviceDataModel?.ownedBy
        tfStatus.text = deviceDataModel?.status
        tfSupportGroup.text = deviceDataModel?.supportGroup
        tfAssignmentGroup.text = deviceDataModel?.assignmentGroup
        tvSubLocation.text = deviceDataModel?.subLocation
        tvLocation.text = deviceDataModel?.location
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDeviceInfoController" {
            
            // complete PUT request with data
            
        }
        
    }
    
    func updateModel(json: JSON) {
        deviceDataModel?.name = tfName.text!
        deviceDataModel?.ownedBy = tfOwnedBy.text!
        deviceDataModel?.status = tfStatus.text!
        deviceDataModel?.assignmentGroup = tfAssignmentGroup.text!
    }

}
