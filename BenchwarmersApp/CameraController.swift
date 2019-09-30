//
//  CameraHandler.swift
//  BenchwarmersApp
//
//  Created by Jordan Cahill on 9/28/19.
//  Copyright © 2019 sogeti-benchwarmers. All rights reserved.
//
//  Ref:
//  https://hackernoon.com/swift-access-ios-camera-and-photo-library-dc1dbe0cdd76
//  https://medium.com/@deepakrajmurugesan/swift-access-ios-camera-photo-library-video-and-file-from-user-device-6a7fd66beca2

import Foundation
import UIKit

class CameraHandler: NSObject {
    static let shared = CameraHandler()
    fileprivate var currentVC: UIViewController?
    var imagePicked: ((UIImage) -> Void)?
    
    func camera(vc: UIViewController) {
        currentVC = vc
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            currentVC?.present(myPickerController, animated: true, completion: nil)
        } else {
            print("User does not have permissions set to access their camera from this app")
        }
    }
}

extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imagePicked?(image)
        } else {
            print("Did not receive image")
        }
        currentVC?.dismiss(animated: true, completion: nil)
    }
}
