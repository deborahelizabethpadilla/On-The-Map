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
    
    fileprivate func viewMap() {
    UIView.animate(withDuration: 0.5, animations: {
    self.label.isHidden = true
    self.locationtext.alpha = 0.0
    self.onthemapButton.alpha = 0
    self.submitButton.isHidden = false
    self.onthemapButton.isEnabled = false
    self.linktext.alpha = 1
    self.view.backgroundColor = self.locationtext.backgroundColor
    self.cancelButton.titleLabel?.textColor = UIColor.white
    })
        
    let place = MKPlacemark(placemark: self.cords!)
    self.mapinfoView.addAnnotation(place)
        
    let region = MKCoordinateRegionMakeWithDistance((place.location?.coordinate)!, 5000.0, 7000.0)
        
    mapinfoView.setRegion(region, animated: true)
        
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
    dismissKeyboard()
    return false
    }
    return true
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {
    dismissKeyboard()
    }
        
    func textViewDidBeginEditing(_ textView: UITextView) {
    textView.text = nil
    }
    }
    }


