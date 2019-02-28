//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/17/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
class UdacityClient:CommonClient{
    let url="https://onthemap-api.udacity.com/v1/"
    var userId:String=""
    var sessionId:String=""
    var headers: [String: String] = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    // Singleton instance of ParseClient
    static let shared = UdacityClient()
    
    private override init() {
        super.init()
                
    }
    
    func postSession(email: String,password: String, handler: @escaping (_ response: [AnyObject]?, _ error: String?) -> Void){
        let body:AnyObject = ["udacity": [
            "username": email,
             "password": password
             ]
        ] as AnyObject

        // prepare request
        let request=prepareRequest(url: "\(url)session",headers: self.headers, method: "POST",body:body)
        // proccess request
        processResuest(request: request,forUdacity: "y") { (result, error) -> Void in
            guard error == nil else {
                handler(nil, error)
                return
            }
            
            guard let account = result!["account"] as? [String : AnyObject], let userId = account["key"] as? String , let session = result!["session"] as? [String : AnyObject], let sessionId = session["id"] as? String else {
                print("Somthing Wrong")
                handler(nil ,"Username or password is incorrect")
                return
            }
            
            
            self.sessionId=sessionId
            self.userId=userId
            handler(result as? [AnyObject],nil)

    }
        
    }
    
    func logout(handler: @escaping (_ error: String?) -> Void){
        let request = prepareRequest(url: "\(url)session", headers: self.headers, method: "DELETE")
        for cookie in HTTPCookieStorage.shared.cookies! where cookie.name == "XSRF-TOKEN" {
            request.setValue(cookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        processResuest(request: request) { (result, error) -> Void in
            guard error == nil else {
                handler(error)
                return
            }
            
            guard let session = result!["session"] as? [String : AnyObject], let sessionId = session["id"] as? String else {
                print("Can't find session")
                handler("Can't find session")
                return
            }
            
            self.sessionId = sessionId
            self.userId = ""
            handler(nil)
        }
        
    }
    
    func getUser(id: String, handler: @escaping (_ user: [String : AnyObject]?, _ error: String?) -> Void) {
        
        let request = prepareRequest(url: "\(self.url)users/\(id)", headers: self.headers, method: "GET")
        
        processResuest(request: request,forUdacity: "y") { (result, error) -> Void in
            // Check for error
            guard error == nil else {
                handler(nil, error)
                return
            }
            
            guard let userData = result!["user"] as? [String : AnyObject] else {
                print("Can't find [user] in response")
                handler(nil, "Connection error")
                return
            }
            
            guard let firstName = userData["first_name"] as? String, let lastName = userData["last_name"] as? String else {
                print("Can't find [user]['first_name'] or [user]['last_name'] in response")
                handler(nil, "Connection error")
                return
            }
            
            let user =  [
                "id": id,
                "firstName": firstName,
                "lastName": lastName,
                ] as [String : AnyObject]
            
            handler(user as [String : AnyObject], nil)
        }
    }

}
