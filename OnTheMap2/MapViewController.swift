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
    
    //Map View Info
    
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
    
    //Create Map View
    
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
    
    //Map View Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                if UdacityNetwork.sharedInstance().checkURL(toOpen){
                    app.openURL(URL(string: toOpen)!)
                } else {
                    UdacityNetwork.sharedInstance().alertError(self, error: self.appDelegate.errorMessage.InvalidLink)
                }
            }
        }
    }
    
}
