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
            updateModel()
            
            // complete PUT request with device data model data
            
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
                
                print("made a selection \(selection)")
                
                // display the formatted location text in the location text box
                // and update the device data model
                
            })
        })
    }
    
    @IBAction func doEditSubLocation(_ sender: Any) {
    }
    
    @IBAction func doEditSupportGroup(_ sender: Any) {
    }
    
    func displayPickerViewModal(title: String, picker: LocationPicker, onEdit: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = picker as UIPickerViewDataSource
        pickerFrame.delegate = picker as UIPickerViewDelegate
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            onEdit(picker.selection!)
        }))
        self.present(alert,animated: true, completion: nil )
    }
}
