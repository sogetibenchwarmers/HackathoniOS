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
    
    @IBOutlet weak var tfAssetTag: UITextView!
    @IBOutlet weak var tfName: UITextView!
    @IBOutlet weak var tfOwnedBy: UITextView!
    @IBOutlet weak var tvLocation: UITextView!
    @IBOutlet weak var tvSubLocation: UITextView!
    @IBOutlet weak var tfStatus: UITextView!
    @IBOutlet weak var tfSupportGroup: UITextView!
    @IBOutlet weak var tfAssignmentGroup: UITextView!
    
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
        
        if segue.identifier == "toDeviceInfoControllerOnSubmit" {
            print("\n\n\n\n\n\n\n\n\n\n\n\n SEGUE \n\n\n\n")
            updateModel()
            
            let requestBody = [
                "name": deviceDataModel?.name,
                "ownedBy": deviceDataModel?.ownedBy,
                "locationId": deviceDataModel?.locationId,
                "sublocationId": deviceDataModel?.subLocationId,
                "status": deviceDataModel?.status,
                "supportGroupId": deviceDataModel?.supportGroupId,
                "assignmentGroup": deviceDataModel?.assignmentGroup
            ]
            
            let assetUrl = baseAssetUrl + deviceDataModel!.assetTag
            Alamofire.request(assetUrl, method: .put, parameters: requestBody as Parameters, encoding: JSONEncoding.default).responseJSON {
                response in
                if response.result.isSuccess {
                    print("updated device data")
                }
                else {
                    // display error
                    
                    print("error updating device info")
                    print(response.error!)
                }
            }
            
        }
        
    }
    
    func updateModel() {
        deviceDataModel?.name = tfName.text!
        deviceDataModel?.ownedBy = tfOwnedBy.text!
        deviceDataModel?.status = tfStatus.text!
        deviceDataModel?.assignmentGroup = tfAssignmentGroup.text!
    }

    @IBAction func doEditLocation(_ sender: Any) {
        let picker = LocationPicker()
        picker.getLocations(completion: { () in
            self.displayPickerViewModal(title: "Edit Location", picker: picker, onEdit: { (selection) in
                var locationInfo = selection;
                locationInfo.dictionaryObject?.removeValue(forKey: "id")
                let formattedLocation = self.formatLocation(locationJson: locationInfo)
                
                self.deviceDataModel?.locationId = selection["id"].stringValue
                self.deviceDataModel?.location = formattedLocation
                self.tvLocation.text = formattedLocation
            })
        })
    }
    
    @IBAction func doEditSubLocation(_ sender: Any) {
        let picker = LocationPicker()
        picker.getLocations(completion: { () in
            self.displayPickerViewModal(title: "Edit Sub Location", picker: picker, onEdit: { (selection) in
                var locationInfo = selection;
                locationInfo.dictionaryObject?.removeValue(forKey: "id")
                let formattedLocation = self.formatLocation(locationJson: locationInfo)
                
                self.deviceDataModel?.subLocationId = selection["id"].stringValue
                self.deviceDataModel?.subLocation = formattedLocation
                self.tvSubLocation.text = formattedLocation
            })
        })
    }
    
    @IBAction func doEditSupportGroup(_ sender: Any) {
        let picker = SupportGroupPicker()
        picker.getSupportGroups(completion: { () in
            self.displayPickerViewModal(title: "Edit Support Group", picker: picker, onEdit: { (selection) in
                self.deviceDataModel?.supportGroupId = selection["id"].stringValue
                self.deviceDataModel?.supportGroup = selection["name"].stringValue
                self.tfSupportGroup.text = selection["name"].stringValue
            })
        })
    }
    
    //  Ref:
    //  https://daddycoding.com/2017/07/27/ios-tutorials-pickerview-uialertcontroller/
    
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
