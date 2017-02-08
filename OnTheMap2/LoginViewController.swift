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
    let request = URLRequest(url: URL(string: "https://www.udacity.com/account/auth#!/signup")!)
    UIApplication.shared.openURL(request.url!)
    }

    @IBAction func loginButton(_ sender: Any) {
    dismissKeyboard()
    UdacityAPI.signInWithLogin(usernameField.text!, password: passwordField.text!) { (data, result, error) in
    if error != nil {
    self.errorLabel.text = "Something Went Wrong! Try Again!"
    
    } else {
    UdacityAPI.getPublicData()
    self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
    }
    }
    }
    
    func dismissKeyboard() {
    view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    dismissKeyboard()
    return false
    }
    }


    
    




    
    
    





    
    

    
