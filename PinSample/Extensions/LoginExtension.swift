//
//  LoginExtension.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/27/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit
extension LoginVC: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    
    
    
}
