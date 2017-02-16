//
//  TabBarViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//


import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
}
    @IBAction func logout(_ sender: Any) {
        
    }
    @IBAction func refreshButton(_ sender: Any) {
        
    }
    @IBAction func addLocationButton(_ sender: Any) {
        UdacityNetwork.sharedInstance().addLocation(self)
    }

}
