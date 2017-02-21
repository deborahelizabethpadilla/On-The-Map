//
//  LinkViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/16/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit

class LinkViewController: UIViewController {
    
    //Map Data Info
    
    var location: String = ""
    var appDelegate: AppDelegate!
    var mediaURL: String = ""
    
    var pointAnnotation = MKPointAnnotation()
    var latitude: Double = 0.00
    var longitude: Double = 0.00
    
    let inputDelegate = addLocationDelegate()
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var webLink: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        webLink.delegate = inputDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: pointAnnotation.coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        self.mapView.centerCoordinate = pointAnnotation.coordinate
        self.mapView.addAnnotation(pinAnnotationView.annotation!)
        self.mapView.delegate = self as? MKMapViewDelegate
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        mediaURL = webLink.text!
        
        let userData = UsersInfo(dictionary: ["firstName" : appDelegate.firstName as AnyObject, "lastName": appDelegate.lastName as AnyObject, "mediaURL": mediaURL as AnyObject, "latitude": latitude as AnyObject, "longitude": longitude as AnyObject, "objectId": appDelegate.objectId as AnyObject, "uniqueKey": appDelegate.uniqueKey as AnyObject])
        
        
        if mediaURL == "Enter Location Here" || mediaURL == "" {
            UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.MissingLink)
        } else {
            if UdacityNetwork.sharedInstance().checkURL(webLink.text!) == true {
                if appDelegate.willOverwrite {
                    UdacityNetwork.sharedInstance().updateUserData(student: userData!, location: location) { success, result in
                        DispatchQueue.main.async{
                            if success {
                                UdacityNetwork.sharedInstance().navigateTabBar(self)
                            } else {
                                UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.UpdateError)
                            }
                        }
                    }
                    
                } else {
                   UdacityNetwork.sharedInstance().postNew(student: userData!, location: location) {success, result in
                        DispatchQueue.main.async{
                            if success {
                                UdacityNetwork.sharedInstance().navigateTabBar(self)
                            } else {
                                UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.UpdateError)
                            }
                        }
                    }
                    
                }
           
            }
        }
    
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        
        webLink.resignFirstResponder()
        
        return true
    }
    
}



