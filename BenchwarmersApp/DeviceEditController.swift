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

class DeviceEditController: UIViewController {
    
    var deviceDataModel: DeviceDataModel?
    let baseAssetUrl = "https://hackathon-netcore-api.azurewebsites.net/api/v1/assets/"
    
    @IBOutlet weak var tvAssetTag: UITextView!
    @IBOutlet weak var tvName: UITextView!
    @IBOutlet weak var tvOwnedBy: UITextView!
    @IBOutlet weak var tvLocation: UITextView!
    @IBOutlet weak var tvSubLocation: UITextView!
    @IBOutlet weak var tvStatus: UITextView!
    @IBOutlet weak var tvSupportGroup: UITextView!
    @IBOutlet weak var tvAssignmentGroup: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("device edit controller loading")
        
        let fields = [
            tvAssetTag,
            tvName,
            tvOwnedBy,
            tvStatus,
            tvSupportGroup,
            tvAssignmentGroup,
            tvSubLocation,
            tvLocation!
        ]
        formatFields(fields: fields as! Array<UIView>)
        updateUI()
    }
    
    func updateUI() {
        tvAssetTag.text = deviceDataModel?.assetTag
        tvName.text = deviceDataModel?.name
        tvOwnedBy.text = deviceDataModel?.ownedBy
        tvStatus.text = deviceDataModel?.status
        tvSupportGroup.text = deviceDataModel?.supportGroup
        tvAssignmentGroup.text = deviceDataModel?.assignmentGroup
        tvSubLocation.text = deviceDataModel?.subLocation
        tvLocation.text = deviceDataModel?.location
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDeviceInfoControllerOnSubmit" {
            updateModel()
            
            let requestBody = [
                "name": deviceDataModel?.name,
                "locationId": deviceDataModel?.locationId,
                "sublocationId": deviceDataModel?.subLocationId,
                "status": deviceDataModel?.status,
                "supportGroupId": deviceDataModel?.supportGroupId,
                "assignmentGroup": deviceDataModel?.assignmentGroup
            ]
            
            let assetUrl = baseAssetUrl + deviceDataModel!.assetTag
            Alamofire.request(assetUrl, method: .put, parameters: requestBody as Parameters, encoding: JSONEncoding.default).responseJSON {
                response in
                if response.response?.statusCode == 200 {
                    print("updated device data")
                } else {
                    let controller = segue.destination as! DeviceInfoController
                    self.displayError(
                        errorTitle: "Device Update Error",
                        errorMessage: "Unable to update the device at this time due to an unknown error.",
                        controller: controller
                    )
                }
            }
            
        }
        
    }
    
    func updateModel() {
        deviceDataModel?.name = tvName.text!
        deviceDataModel?.status = tvStatus.text!
        deviceDataModel?.assignmentGroup = tvAssignmentGroup.text!
    }

    @IBAction func doEditLocation(_ sender: Any) {
        let picker = LocationPicker()
        picker.getLocations(controller: self, completion: { () in
            self.displayPickerViewModal(title: "Edit Location", picker: picker, onEdit: { (selection) in
                self.deviceDataModel?.locationId = selection["id"].stringValue
                self.deviceDataModel?.location = selection["name"].stringValue
                self.tvLocation.text = selection["name"].stringValue
            })
        })
    }
    
    @IBAction func doEditSubLocation(_ sender: Any) {
        let picker = LocationPicker()
        picker.getLocations(controller: self, completion: { () in
            self.displayPickerViewModal(title: "Edit Sub Location", picker: picker, onEdit: { (selection) in
                self.deviceDataModel?.subLocationId = selection["id"].stringValue
                self.deviceDataModel?.subLocation = selection["name"].stringValue
                self.tvSubLocation.text = selection["name"].stringValue
            })
        })
    }
    
    @IBAction func doEditSupportGroup(_ sender: Any) {
        let picker = SupportGroupPicker()
        picker.getSupportGroups(controller: self, completion: { () in
            self.displayPickerViewModal(title: "Edit Support Group", picker: picker, onEdit: { (selection) in
                self.deviceDataModel?.supportGroupId = selection["id"].stringValue
                self.deviceDataModel?.supportGroup = selection["name"].stringValue
                self.tvSupportGroup.text = selection["name"].stringValue
            })
        })
    }
    
    //  Ref: https://daddycoding.com/2017/07/27/ios-tutorials-pickerview-uialertcontroller/
    
    func displayPickerViewModal(title: String, picker: BenchwarmersPicker, onEdit: @escaping (JSON) -> Void) {
        let alert = UIAlertController(title: title, message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = picker
        pickerFrame.delegate = picker
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            onEdit(picker.selection!)
        }))
        self.present(alert,animated: true, completion: nil )
    }
}
