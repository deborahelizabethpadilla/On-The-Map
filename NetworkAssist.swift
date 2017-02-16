//
//  NetworkAssist.swift
//  OnTheMap2
//
//  Created by Deborah on 2/15/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class Indicator: UIActivityIndicatorView {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate 
    
    required init(coder aDecoder: NSCoder){
        fatalError("use init(")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    }
    
    func loadingView(_ isloading: Bool) {
        if isloading {
            self.startAnimating()
        } else {
            self.stopAnimating()
            self.hidesWhenStopped = true
            
        }
    }
    
}

extension UdacityNetwork {
    
    func logout(_ controller: UIViewController) {
        logoutID(controller: controller)
        controller.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    func addLocation(_ controller: UIViewController) {
        let AlertController = UIAlertController(title: "", message: "User \(appDelegate.firstName) \(appDelegate.lastName) Already Posted A Student Location. Would You Like To Overwrite Their Location?", preferredStyle: .alert)
        let InfoViewController = controller.storyboard!.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        let willOverwriteAlert = UIAlertAction(title: "Overwrite", style: UIAlertActionStyle.default) {
            action in controller.present(InfoViewController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            action in AlertController.dismiss(animated: true, completion: nil)
        }
        
        AlertController.addAction(willOverwriteAlert)
        AlertController.addAction(cancelAction)
        
        
        if (UIApplication.shared.delegate as! AppDelegate).willOverwrite {
            controller.present(AlertController, animated:true, completion: nil)
        } else {
            controller.present(InfoViewController, animated: true, completion: nil)
        }
    }
    
    //Navigation
    func navigateTabBar(_ controller: UIViewController) {
        let TabBarController = controller.storyboard!.instantiateViewController(withIdentifier: "MapViewController") as! UITabBarController
        controller.present(TabBarController, animated: true, completion: nil)
    }
    
    func checkURL(_ url: String) -> Bool {
        if let url = URL(string: url) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
}

    //Error Messages

struct ErrorMessage {
    let DataError = "There was en error retrieving student data."
    let MapError = "Could not GeoCode the String"
    let UpdateError = "Failed to Update Location"
    let InvalidLink = "Invalid Link"
    let MissingLink = "Must Enter a Link"
    let CantLogin = "The internet connection appears to be offline"
    let InvalidEmail = "Invalid Email or Password"
}


extension UdacityNetwork {
    
    func alertError(_ controller: UIViewController, error: String) {
        let AlertController = UIAlertController(title: "", message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
            action in AlertController.dismiss(animated: true, completion: nil)
        }
        AlertController.addAction(cancelAction)
        controller.present(AlertController, animated: true, completion: nil)
    }
    
}

class addLocationDelegate: NSObject, UITextFieldDelegate {
    
    override init() {
        super.init()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
