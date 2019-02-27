//
//  LoginVC.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/17/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate=self
        passwordTextField.delegate=self
        
    }
    @IBAction func login(_ sender: Any) {
        emailTextField.text="muhammadelbadawy10@gmail.com"
        passwordTextField.text="qazxcdews"
        // Try to login with Udacity API
        UdacityClient.shared.postSession(email: emailTextField.text!, password: passwordTextField.text!) { (result,error: String?) in
            
            DispatchQueue.main.async {
                guard error == nil else {
//                    self.showErrorAlert(error!)
                    print("error",error!)
                   return
                }
                
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController")
                self.present(vc!, animated: true, completion: nil)
                
//                print("result from vc",result!)
            }
        }
    }
    
}
