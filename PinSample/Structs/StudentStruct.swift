//
//  StudentStruct.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/23/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation


struct StudentStruct {
    
    var firstName: String?
    var lastName: String?
    var longitude: Double?
    var latitude: Double?
    var mediaUrl: String?
    var mapString: String?
    var objectId: String?
    var uniqueKey: String?
 
    
    /*
     * Construct a student from a dictionary
     */
    init(dictionary: [String : AnyObject]) {
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        longitude = dictionary["longitude"] as? Double
        latitude = dictionary["latitude"] as? Double
        mediaUrl = dictionary["mediaURL"] as? String
        mapString = dictionary["mapString"] as? String
        objectId = dictionary["objectId"] as? String
        uniqueKey = dictionary["uniqueKey"] as? String
    }
}
