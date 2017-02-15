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
    
    let invalidURL = "Invalid URL!"
    let invalidLinkMessage = "Oops! It Doesn't Work!"
    let reuseId = "reusableAnnotationPin"
    let returnTitle = "Return"
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
    }
    
    func studentInfoUpdated() {
        let students = StudentInfoController.people
        var annotations = [MKPointAnnotation]()
        
        DispatchQueue.main.async {
            
            for annotation in self.mapView.annotations {
                self.mapView.removeAnnotation(annotation)
            }
        }
        
        for student in students {
            
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = student.firstName
            let last = student.lastName
            let mediaURL = student.mediaURL
            
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotations(annotations)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = UIColor.red
            pinView!.canShowCallout = true
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
            
            guard let providedURL = view.annotation?.subtitle, providedURL != nil,
                
                let url1 = URL(string: providedURL!), app.openURL(url1) == true else {
                    
                    let alertViewMessage = invalidLinkMessage
                    let alertActionTitle = returnTitle
                    presentAlert(invalidURL, message: alertViewMessage, actionTitle: alertActionTitle)
                    
                    return
            }
            
        }
    
    }
    }

