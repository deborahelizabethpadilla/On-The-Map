//
//  Extra Additions.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func tapOutKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentAlert(_ error: NSError) {
        presentAlert("Error", message: error.localizedDescription, actionTitle: "OK", actionHandler: nil)
    }
    
    func presentAlert(_ title: String, message: String, actionTitle: String, actionHandler: ((UIAlertAction) -> Void)?) {
        
        let alertControllerStyle = UIAlertControllerStyle.alert
        let alertView = UIAlertController(title: title, message: message, preferredStyle: alertControllerStyle)
        
        let alertActionStyle = UIAlertActionStyle.default
        let alertAction = UIAlertAction(title: actionTitle, style: alertActionStyle, handler: actionHandler)
        
        alertView.addAction(alertAction)
        
        DispatchQueue.main.async(execute: {
            self.present(alertView, animated: true, completion: nil)
        })
    }
    
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
    
    func showSpinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        DispatchQueue.main.async(execute: {
            spinner.center = self.view.center
            spinner.color = UIColor.orange
            self.view.addSubview(spinner)
            spinner.startAnimating()
        })
        
        return spinner
    }
}


extension UIActivityIndicatorView {
    func hide() {
        DispatchQueue.main.async(execute: {
            self.stopAnimating()
            self.removeFromSuperview()
        })
    }
}
