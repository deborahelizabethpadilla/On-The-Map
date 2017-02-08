//
//  ViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func signupButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    }

    @IBAction func loginButton(_ sender: Any) {
    dismissKeyboard()
    guard let username = usernameField.text, let password = passwordField.text else {
    return
    }
    }

    let spinner = showSpinner()
    UdacityAPI.signInWithLogin(username, password: password) { (data, response, error) in
    spinner.hide()
    
    if let response = response as? HTTPURLResponse {
    if response.statusCode < 200 || response.statusCode > 300 {
    self.presentAlert("Oops!", message: "Try Again Later!", actionTitle: "Return")
    return
    
    }
    
    if let error = error {
    if error.code == NSURLErrorNotConnectedToInternet {
    
    let alertViewMessage = self.invalidLinkMessage
    let okActionAlertTitle = "OK"
    
    self.presentAlert("Not Working!", message: alertViewMessage, actionTitle: okActionAlertTitle, actionHandler: nil)
    }
    
    } else {
    do {
    if let json = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as? [String:AnyObject] {
    if let accountDict = json["account"] as? [String:AnyObject] {
    User.uniqueKey = accountDict["key"] as! String
    DispatchQueue.main.async(execute: {
    
    if let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") {
    self.present(tabBarVC, animated: true, completion: nil)
    }
    })
    } else {
    
    self.presentAlert("Incorrect Login", message: "Username/Password Incorect", actionTitle: "OK")
    }
    }
    
    } catch {
    
    }
    }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    dismissKeyboard()
    return false
    }
    func tapOutKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(LoginViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
    }
    
    }

    }
