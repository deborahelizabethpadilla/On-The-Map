//
//  TableViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Table View Data
    
    var indicator = Indicator()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func refreshButton(_ sender: Any) {
        indicator.loadingView(true)
        loadTableView()
    }
    @IBAction func addLocation(_ sender: Any) {
        UdacityNetwork.sharedInstance().addLocation(self)
    }
    @IBAction func logoutButton(_ sender: Any) {
        UdacityNetwork.sharedInstance().logout(self)
        
    }
    
    override func viewDidLoad() {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicator.loadingView(true)
        loadTableView()
    }
    
    func loadTableView() {
        UdacityNetwork.sharedInstance().getUsersData {(success, error) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.indicator.loadingView(false)
                }
                
            } else {
                UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.DataError)
            }
        }
    }
    
    //Table View Data Info
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersInfo.UsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell")!
        let student = UsersInfo.UsersArray[indexPath.row]
        
        
        cell.textLabel?.text = "\(student.firstName) \(student.lastName)"
        cell.imageView?.image = UIImage(named: "pin")
        cell.detailTextLabel?.text = student.mediaURL
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = UsersInfo.UsersArray[indexPath.row]
        let app = UIApplication.shared
        if UdacityNetwork.sharedInstance().checkURL(student.mediaURL){
            app.openURL(URL(string: student.mediaURL)!)
        } else {
            UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.InvalidLink)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        return true;
    }
    
}
