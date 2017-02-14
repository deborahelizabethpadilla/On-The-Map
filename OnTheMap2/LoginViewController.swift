//
//  ViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let invalidNetwork = "Oh Snap! You Don't Have Internet!"

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message: String) {
        
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
    self.dismiss(animated: true, completion: nil)
    }))
    self.present(alert, animated: true, completion: nil)
        
    }
    
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
    self.view.endEditing(true)
    
    if usernameField.text == "" || passwordField.text == "" {
            
    displayAlert(title: "Oh Snap!", message: "Something Went Wrong! Try Again!")
        
    } else {
            
    activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    activityIndicator.center = self.view.center
    activityIndicator.hidesWhenStopped = true
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    let spinner = showSpinner()
    UdacityAPI.signInWithLogin(usernameField.text!, password: passwordField.text!) { (user, error) -> in
    spinner.hide()
    if user != nil {
        
    //Logged In!
        
    self.performSegue(withIdentifier: "login", sender: self)
    if let json = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as? [String:AnyObject] {
    if let accountDict = json["account"] as? [String:AnyObject] {
    Users.uniqueKey = accountDict["key"] as! String
    DispatchQueue.main.async(execute: {
        
    //Present The Map And Tabbed View
    if let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") {
    self.present(tabBarVC, animated: true, completion: nil)
    }
    })
    
    } else {
        
    self.displayAlert(title: "Failed Logging In!", message: errorMessage)
    
    }
    if let response = user as? HTTPURLResponse {
    if response.statusCode < 200 || response.statusCode > 300 {
    self.displayAlert(title: "Try Again Later!", message: "Error!")
    return
    }
    }
    if let error = error {
    //Network Error
    if error.code == NSURLErrorNotConnectedToInternet {
                
    let alertViewMessage = self.invalidNetwork
    let okActionAlertTitle = "OK"
                
    self.presentAlert("Not Online!", message: alertViewMessage, actionTitle: okActionAlertTitle, actionHandler: nil)
                
    }
    }
    }
    }
    }
    }
    }








