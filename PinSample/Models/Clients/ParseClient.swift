//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/17/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
class ParseClient:CommonClient{
    
    let url="https://parse.udacity.com/parse/classes/"
    let parse_app_id="QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    var headers: [String: String] = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    // Singleton instance of ParseClient
    static let shared = ParseClient()
    
    private override init() {
        super.init()
       
        // Auth Static Headers
        headers["X-Parse-Application-Id"] = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        headers["X-Parse-REST-API-Key"] = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"

    }
    
    
    func getOneStudent(uniqueKey: String, handler: @escaping (_ student: StudentStruct?, _ error: String?) -> Void) {
        
        let request = prepareRequest(url: "\(self.url)StudentLocation", headers:self.headers,method: "GET", params: ["where": "{\"uniqueKey\":\"\(uniqueKey)\"}" as AnyObject])
        
        processResuest(request: request) { (result, error) -> Void in
            guard error == nil else {
                handler(nil, error)
                return
            }
            
            guard let results = result!["results"] as? [[String : AnyObject]] else {
                print("Can't find [results] in response")
                handler(nil, "Connection error")
                return
            }
            
            if let dictionary = results.first {
                handler(StudentStruct(dictionary: dictionary), nil)
            }
            else {
                handler(nil, nil)
            }
        }
    }
    
    func createStudent(student: StudentStruct, handler: @escaping (_ error: String?) -> Void) {
        let request = prepareRequest(url: "\(self.url)StudentLocation", headers: self.headers, method: "POST", body: [
            "uniqueKey": student.uniqueKey!,
            "firstName": student.firstName ?? "",
            "lastName": student.lastName ?? "",
            "mapString": student.mapString ?? "",
            "mediaURL": student.mediaUrl ?? "",
            "latitude": student.latitude!,
            "longitude": student.longitude! ,
            ] as AnyObject)
        
        processResuest(request: request) { (result, error) -> Void in
            handler(error)
        }
    }
    
    func updateStudent(student: StudentStruct, handler: @escaping (_ error: String?) -> Void) {
        let request = prepareRequest(url: "\(self.url)StudentLocation/\(student.objectId)", headers: self.headers, method: "PUT", body: [
            "uniqueKey": student.uniqueKey!,
            "firstName": student.firstName ?? "",
            "lastName": student.lastName ?? "",
            "mapString": student.mapString ?? "",
            "mediaURL": student.mediaUrl ?? "",
            "latitude": student.latitude!,
            "longitude": student.longitude!,
            ] as AnyObject)
        
        processResuest(request: request) { (result, error) -> Void in
            handler(error)
        }
    }
    
    
    func getAllStudents(handler: @escaping (_ students: [StudentStruct]?, _ error: String?) -> Void) {
        let params = [
            "limit":"100",
            "skip":"400"
        ]as [String : AnyObject]
        
        // prepare request
        var request=prepareRequest(url: "\(url)StudentLocation",headers: self.headers , method: "GET", params:params ,body:nil)
        // proccess request
        processResuest(request: request) { (result, error) -> Void in
            guard error == nil else {
                handler(nil, error)
                return
            }
            
            guard let results = result!["results"] as? [[String : AnyObject]] else {
                print("Can't find [results] in response")
                handler(nil, "Connection error")
                return
            }
            
          var students: [StudentStruct] = []

            for result in results {
                students.append(StudentStruct(dictionary: result))
            }
            


            handler(students as [StudentStruct], nil)
        }
        
        
        
    }
    
    
    
    

    
}

