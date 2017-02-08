//
//  InfoViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class InfoViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet var onthemapButton: UIButton!
    @IBOutlet var mapinfoView: MKMapView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var linktext: UITextView!
    @IBOutlet var locationtext: UITextView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var label: UILabel!
    
    let geoCodeError = "Cannot Geocode!"
    
    var activityIndicator: UIActivityIndicatorView?
    var cords : CLPlacemark?
    
    override func viewDidLoad() {
        
    linktext.delegate = self
    self.locationtext.delegate = self
    self.linktext.alpha = 0
    self.submitButton.isHidden = true
    tapOutKeyboard()
    linktext.returnKeyType = .done
    locationtext.returnKeyType = .done
        
    }
    
    }
