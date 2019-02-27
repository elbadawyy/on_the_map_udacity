//
//  SubmitVC.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/26/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class SubmitVC: UIViewController{
    
    var address:String = ""
    var coordinate:CLLocationCoordinate2D?
    @IBOutlet weak var whereQuestionLabel: UILabel!
    @IBOutlet weak var findOnMapBtn: UIButton!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var SubmitBtn: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterYourAdressMode()
        
        answerTextField.delegate = self
        
    }
    
    func enterYourAdressMode(){
        whereQuestionLabel.isHidden=false
        findOnMapBtn.isHidden=false
        
        
        mapView.isHidden=true
        SubmitBtn.isHidden=true
        answerTextField.placeholder="Enter Your Address Here"
        
        
    }
    
    func enterSubmitMode() {
        self.address=answerTextField.text!
        answerTextField.text=""
        whereQuestionLabel.isHidden=true
        findOnMapBtn.isHidden=true
        
        mapView.isHidden=false
        SubmitBtn.isHidden=false
        answerTextField.placeholder="Add Your Link Here"

    }
    
    
    @IBAction func findOnMap(_ sender: Any) {
        
        let location = answerTextField.text
        CLGeocoder().geocodeAddressString(location ?? "Egypt, Alexandria") { (placemark, error) in
            self.coordinate = placemark!.first!.location!.coordinate
            print("cord => ",self.coordinate)
            let annotation = MKPointAnnotation()
            annotation.coordinate = self.coordinate!
            annotation.title = location
            
            let region = MKCoordinateRegionMake(self.coordinate!, MKCoordinateSpanMake(0.01, 0.01))
            
             DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
                self.mapView.setRegion(region, animated: true)
                self.mapView.regionThatFits(region)
            
            }
           
            
            self.enterSubmitMode()
        }
        
    }
    
    
    @IBAction func submit(_ sender: Any) {
        let url = answerTextField.text!
        
        UdacityClient.shared.getUser(id: UdacityClient.shared.userId) { (user, error) -> Void in
   
            
            // Student data doesn't matter creating or updating
            var student = StudentStruct(dictionary: [
                "firstName": user?["firstName"] ?? "" as AnyObject,
                "lastName": user?["lastName"] ?? ""  as AnyObject  ,
                "longitude": Double(self.coordinate!.longitude) as AnyObject,
                "latitude": Double(self.coordinate!.latitude) as AnyObject,
                "mediaURL": url as AnyObject as AnyObject ,
                "mapString": self.address as AnyObject,
                "uniqueKey": user?["id"] ?? ""  as AnyObject,
                "objectId": "" as AnyObject,
                ])
            
            if ShardData.shared.student == nil {
                // Create student
                ParseClient.shared.createStudent(student: student, handler: self.saveHandler as! (String?) -> Void)
            }
            else {
                // Update student
                student.objectId = ShardData.shared.student!.objectId
                ParseClient.shared.updateStudent(student: student, handler: self.saveHandler as! (String?) -> Void)
            }
        }

        
    }
    
    
    @IBAction func cancel(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveHandler(response:String?) -> Void{
    
    }

}
