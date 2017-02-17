//
//  MapViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var annotations = [MKPointAnnotation]()
    var indicator = Indicator()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadMapView()
        indicator.loadingView(true)
    }
    
    @IBAction func insertLocation(_ sender: Any) {
        
    }
    
    @IBAction func logout(_ sender: Any) {
        UdacityNetwork.sharedInstance().logoutID(controller: self)
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        indicator.loadingView(true)
    }
    
    func loadMap() {
        self.mapView.removeAnnotations(annotations)
        annotations = [MKPointAnnotation]()
        
        for dictionary in UsersInfo.UsersArray {
            let lat = dictionary.lat
            let long = dictionary.long
            //unwrap?
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
        
    }

    func loadMapView() {
        UdacityNetwork.sharedInstance().getUsersData() {(success, error) in
            if success {
                DispatchQueue.main.async {
                    self.loadMap()
                    self.indicator.loadingView(false)
                }
                
            } else {
                UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.DataError)
            }
        }
    }

}
