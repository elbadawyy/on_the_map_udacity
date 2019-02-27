//
//  StudentsTableViewVC.swift
//  OnTheMap
//
//  Created by Muhammad El-Badawy on 2/21/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class StudentsTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var students:[StudentStruct] = []

    var firstName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!ShardData.shared.students.isEmpty) {
            return
        }
        ParseClient.shared.getAllStudents { (items , error) in
            self.firstName = items![0].firstName!
            print("yes =>",items![0].firstName!)
            self.students=items as! [StudentStruct]
            ShardData.shared.students=self.students
            print("yes =>",self.students[0])
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name:String
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell",for:indexPath)

        if let firstName = students[indexPath.row].firstName {
            name = firstName
            if let lastName = students[indexPath.row].lastName{
                name.append(" \(lastName)")
            }
        }
        else{
            name = "no Name"
        }
        cell.textLabel?.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = self.students[indexPath.row].mediaUrl {
            
            let app = UIApplication.shared
            let url = URL(string: url)
            app.openURL(url!)
           
           
        }
        
        

    }
    
    
}
