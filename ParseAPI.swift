//
//  ParseAPI.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation

let StudentLocationFailed = "StudentLocationFailed"

struct ParseAPI {
    
    static let url = URL(string: "https://api.parse.com/1/classes/StudentLocation")
    static let session = URLSession.shared
    
    static func getLocationInfo() -> Void {
        
    var urlComponents = URLComponents(string: url!.absoluteString)
    urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "100"), URLQueryItem(name: "order", value: "-updatedAt")]
        
    guard (urlComponents?.url) != nil else {
    return
    }
        
    urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "100"), URLQueryItem(name: "order", value: "-updatedAt")]
        
    let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
    if error != nil {
    return
                
    }
    print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
    }
        
    task.resume()
        
    }
    
    static func postUserLocation(_ completion: RequestCompletionHandler?) {
        
    let request = NSMutableURLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
    request.httpMethod = "POST"
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: String.Encoding.utf8)
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
    if error != nil { // Handle error…
    return
    }
            
    print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
    }
        
    task.resume()
        
    }
    
    static func postUserLocation(_ completion: RequestCompletionHandler?) {
        
    let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/8ZExGR5uX8"
    let url = URL(string: urlString)
    let request = NSMutableURLRequest(url: url!)
    request.httpMethod = "PUT"
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: String.Encoding.utf8)
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
    if error != nil { // Handle error…
    return
                
    }
    print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
    }
        
    }
    
    }
