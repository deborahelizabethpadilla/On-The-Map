//
//  UdacityAPI.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation

typealias RequestCompletionHandler = (_ data: Data?, _ response: URLResponse?, _ error: NSError?) -> Void

    struct UdacityAPI {
    
    static let url = URL(string: "https://www.udacity.com/api/session")
    static let session = URLSession.shared
    
    static func signInWithLogin(_ username: String, password: String, completion: RequestCompletionHandler?) {
        
    let request = NSMutableURLRequest(url: url!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
    if error != nil {
    if let completion = completion {
    completion(nil, nil, error as NSError?)
    }
    return
    }
    let range = Range(uncheckedBounds: (5, data!.count - 5))
    let newData = data?.subdata(in: range)
    print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
    }
    task.resume()
    }
    
    static func getPublicData() {
        
    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/users/3903878747")!)
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
    if error != nil {
    return
    }
    let range = Range(uncheckedBounds: (5, data!.count - 5))
    let newData = data?.subdata(in: range)
    print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
    }
    task.resume()
    }
    
    static func loggingOut() {
        
    let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
    request.httpMethod = "DELETE"
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
    for cookie in sharedCookieStorage.cookies! {
    if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
    }
    if let xsrfCookie = xsrfCookie {
    request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
    }
        
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
    if error != nil {
    return
    }
    let range = Range(uncheckedBounds: (5, data!.count - 5))
    let newData = data?.subdata(in: range)
    print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
    }
    task.resume()
    }
    
    }
