//
//  TabBarVC.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/27/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TabBarVC:UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(!ShardData.shared.students.isEmpty) {
            return
        }
        ParseClient.shared.getAllStudents { (items , error) in
            print("tab bar =>",items![0].firstName!)
            ShardData.shared.students=items as! [StudentStruct]
        }
        
    }
    @IBAction func showPinView(_ sender: Any) {
        ParseClient.shared.getOneStudent(uniqueKey: UdacityClient.shared.userId) { (student, error) in
            DispatchQueue.main.async {
                
                ShardData.shared.student = student
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubmitViewId")
                self.present(vc!, animated: true, completion: nil)
              
            }
        }
        
        
        
   
        
    }
    
}
