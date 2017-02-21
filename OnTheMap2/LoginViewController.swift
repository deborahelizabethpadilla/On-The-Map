//
//  ViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Login Info
    
    var appDelegate: AppDelegate!
    var indicator = Indicator()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapOutKeyboard()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func signupButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated")!,
                                  options: [:], completionHandler: nil)
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        dismissKeyboard()
        self.view.endEditing(true)
        loginwithUdacity()
        indicator.loadingView(true)
        
        
    }
    
    //Login To Udacity
    
    func loginwithUdacity() {
        UdacityNetwork.sharedInstance().getUdacityData(username: usernameField.text!, password: passwordField.text!) { (success, errormsg, error) in
            if success {
                UdacityNetwork.sharedInstance().getUserData(userID: self.appDelegate.userID) { (success, error) in
                    DispatchQueue.main.async {
                        if success {
                            self.completeLogin()
                        } else {
                            UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.CantLogin)
                            self.indicator.loadingView(false)
                            
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    UdacityNetwork.sharedInstance().alertError(self, error: errormsg!)
                    self.indicator.loadingView(false)
                }
            }
        }
        
    }
    
    fileprivate func completeLogin() {
        UdacityNetwork.sharedInstance().isExisting(uniqueKey: self.appDelegate.userID)
        UdacityNetwork.sharedInstance().navigateTabBar(self)
        
    }
    
    //Keyboard Notifications
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        self.view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        self.view.frame.origin.y = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
    }
    
}
