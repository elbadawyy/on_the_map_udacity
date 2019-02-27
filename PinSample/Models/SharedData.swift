//
//  SharedData.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/27/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
class ShardData {
    
    
    // Singleton instance of SharedData
    static let shared = ShardData()
    
    // Current logged in user
    var user: AnyObject? = nil
    
    // Student for current user
    var student: StudentStruct? = nil
    
    // Student list for map and table
    var students: [StudentStruct] = [StudentStruct]()
    
}
