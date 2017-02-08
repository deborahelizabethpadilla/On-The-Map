//
//  Extra Additions.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(_ title: String, message: String, actionTitle: String) {
        
    let alertControllerStyle = UIAlertControllerStyle.alert
    let alertView = UIAlertController(title: title, message: message, preferredStyle: alertControllerStyle)
        
    let alertActionStyle = UIAlertActionStyle.default
    let alertActionOK = UIAlertAction(title: actionTitle, style: alertActionStyle, handler: nil)
        
    alertView.addAction(alertActionOK)
        
    DispatchQueue.main.async(execute: {
    self.present(alertView, animated: true, completion: nil)
    })
    }
    func tapOutKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    }
