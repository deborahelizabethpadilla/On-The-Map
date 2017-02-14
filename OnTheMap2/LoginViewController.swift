//
//  ViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let invalidNetwork = "Oh Snap! You Don't Have Internet!"

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
    tapOutKeyboard()
        
    let spacerView = UIView(frame:CGRect(x:0, y:0, width:20, height:10))
    usernameField.leftViewMode = UITextFieldViewMode.always
    usernameField.leftView = spacerView
        
    let anotherSpacerView = UIView(frame:CGRect(x:0, y:0, width:20, height:10))
    passwordField.leftViewMode = UITextFieldViewMode.always
    passwordField.leftView = anotherSpacerView
        
    usernameField.delegate = self
    passwordField.delegate = self
    }
    
    @IBAction func signupButton(_ sender: Any) {
    _ = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController")
    UIApplication.shared.openURL(URL(string: url.URL)!)
    }
    struct url {
    static let URL = "https://www.udacity.com/account/auth#!/signup"
    }

    @IBAction func loginButton(_ sender: Any) {
    dismissKeyboard()
        
    guard let username = usernameField.text, let password = passwordField.text else {
    return
    }
        
    let spinner = showSpinner()
    UdacityAPI.signInWithLogin(username, password: password) { (data, response, error) in
    spinner.hide()
            
    if let response = response as? HTTPURLResponse {
    if response.statusCode < 200 || response.statusCode > 300 {
    self.presentAlert("Try Again Later", message: "There was an error. Please try again later!", actionTitle: "Return")
    return
    }
    }
    if let error = error {
        
    if error.code == NSURLErrorNotConnectedToInternet {
                    
    let alertViewMessage = self.invalidNetwork
    let okActionAlertTitle = "OK"
                    
    self.presentAlert("Not Online", message: alertViewMessage, actionTitle: okActionAlertTitle, actionHandler: nil)
                    
    }
    } else {
    do {
    if let json = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as? [String:AnyObject] {
    if let accountDict = json["account"] as? [String:AnyObject] {
    Users.uniqueKey = accountDict["key"] as! String
    DispatchQueue.main.async(execute: {
    if let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarNavController") {
    self.present(tabBarVC, animated: true, completion: nil)
    }
    })
    } else {
        
    self.presentAlert("Incorrect Login", message: "The username and/or password may be incorrect", actionTitle: "OK")
    }
    }
                    
    } catch {
                    
    }
    }
    }
    }
 
    }


    
