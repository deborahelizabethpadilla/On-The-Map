//
//  InfoViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {
    
    //Users Info Controller Info
    
    var appDelegate: AppDelegate!
    var latitude: Double = 0.00
    var longitude: Double = 0.00
    var addLocation = addLocationDelegate()
    
    var indicator = Indicator()
    
    @IBOutlet var locationText: UITextField!
    
    
    @IBAction func findOTMButton(_ sender: Any) {
        self.indicator.loadingView(true)
        
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = locationText.text
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil{
                UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.MapError)
                self.indicator.loadingView(false)
                return
            }
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = self.locationText.text!
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            self.latitude = localSearchResponse!.boundingRegion.center.latitude
            self.longitude = localSearchResponse!.boundingRegion.center.longitude
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LinkViewController") as! LinkViewController
            controller.location = self.locationText.text!
            controller.pointAnnotation = pointAnnotation
            controller.latitude = self.latitude
            controller.longitude = self.longitude
            self.indicator.loadingView(false)
            self.present(controller, animated: true, completion: nil)
        }
        
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        locationText.delegate = addLocation
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
    }
}

