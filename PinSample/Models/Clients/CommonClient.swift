//
//  CommonClient.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/17/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

//
//  ApiHelper.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/17/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
class CommonClient{
    
    
    // Single Session
    var session: URLSession { return URLSession.shared }
    
   
    
    //    To Encode The Parameters
    func encodeParameters(params: [String: AnyObject]) -> String {
        let components = NSURLComponents()
        components.queryItems = params.map { (URLQueryItem(name: $0, value: String($1 as! String)) as URLQueryItem) }
        
        return components.percentEncodedQuery ?? ""
    }
    
    
    /*
     * Prepare NSMutableURLRequest object to call API
     */
    func prepareRequest(url: String,headers: [String: String], method: String, params: [String: AnyObject] = [String: AnyObject](), body: AnyObject? = nil) -> NSMutableURLRequest {
        let url = url + "?" + self.encodeParameters(params: params)
        let request = NSMutableURLRequest(url: URL(string: url)! as URL)
        request.httpMethod = method
        
        for (header, value) in headers {
            request.addValue(value, forHTTPHeaderField: header)
        }
        
        if body != nil {
            do {
                request.httpBody = try! JSONSerialization.data(withJSONObject: body!, options: [])
            }
        }
        
        return request
    }
    
    /*
     * Send request using session task and try parse result as JSON object
     */
    func processResuest(request: NSMutableURLRequest,forUdacity:String = "n" ,handler: @escaping (_ result: AnyObject?, _ error: String?) -> Void) {
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            // Was there an error?
            guard error == nil else {
                print("Error in response")
                handler(nil, "Connection error")
                return
            }
            
            // Did we get a successful 2XX response?
            guard let status = (response as? HTTPURLResponse)?.statusCode, status != 403 else {
                print("Wrong response status code (403)")
                handler( nil, "Username or password is incorrect")
                return
            }
            
            // Did we get a successful 2XX response?
            guard status >= 200 && status <= 299 else {
                print("Wrong response status code \(status)")
                handler ( nil, "Connection error")
                return
            }
            
            // Was there any data returned?
            guard var data = self.processResponseData(data: data! as NSData) as Data? else {
                print("Wrong response data")
                handler(nil, "Connection error")
                return
            }
            
            if forUdacity=="y"{
                let range = Range(5..<data.count)
                data = data.subdata(in: range) /* subset response data! */
                
            }
            
            let json:[String:AnyObject]!
            do {
                json = try JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject]
                
//                print("yes write ",json)
            } catch {
                print("JSON converting error ",data )
                handler(nil, "Connection error")
                return
            }
            
            handler(json! as AnyObject,nil)
        }
        
        task.resume()
    }
    
    
    /*
     * Process response data for next parsing
     */
    func processResponseData(data: NSData?) -> NSData? {
        return data!
    }
    
    
    
}
