//
//  TabBarViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//


import UIKit

class TabBarController: UITabBarController {
    
    let logoutbuttonTitle = "Logout"
    let pinInfo = "pinInfo"
    let pinName = "pin"
    let unwindFromLogoutButtonSegueID = "unwindFromLogoutButton"
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    navigationItem.title = "On The Map"
        
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: logoutbuttonTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(doLogout))
        
    let pinButton = UIBarButtonItem(image: UIImage(named: pinName), style: UIBarButtonItemStyle.plain, target: self, action: #selector(postInformation))
        
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(retrieveUserData))
        
    navigationItem.rightBarButtonItems = [refreshButton, pinButton]
        
    NotificationCenter.default.addObserver(self, selector: #selector(updateDataFailed), name: NSNotification.Name(rawValue: StudentInfoUpdated), object: nil)
        
    retrieveUserData()
    UdacityAPI.getPublicData()
        
    UdacityAPI.session.dataTask(with: url) { (data, response, error) in
    if let error = Error {
    self.presentAlert(error)
            
    }
    }
    

    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    retrieveUserData()
    }
    
    let noLink = "Oops! No Connection!"
    func updateDataFailed() {
    self.presentAlert("Update Failed!", message: noLink, actionTitle: "OK")
    }
    
    func doLogout() {
    UdacityAPI.loggingOut()
    dismiss(animated: true, completion: nil)
    }
    
    func postInformation() {
    performSegue(withIdentifier: pinInfo, sender: nil)
    }
    
    func retrieveUserData() {
    ParseAPI.getLocationInfo()
    }
    
    }


    
    func postInformation() {
    
    
    func retrieveUserData() {
    ParseAPI.getLocationInfo()
    }
    
    }

