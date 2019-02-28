//
//  CommonExtension.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/28/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    
    func showErrorAlert(message: String, dismissButtonTitle: String = "OK") {
        let controller = UIAlertController(title: "Something Wrong !!", message: message, preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: dismissButtonTitle, style: .default) { (action: UIAlertAction!) in
            controller.dismiss(animated: true, completion: nil)
        })
        
        self.present(controller, animated: true, completion: nil)
    }
}
