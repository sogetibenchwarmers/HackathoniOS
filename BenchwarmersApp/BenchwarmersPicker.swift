//
//  BenchwarmersPicker.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 10/13/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class BenchwarmersPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var selection: JSON? = nil
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // to satisfy protocol
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // to satisfy protocol
        return 0
    }
}
