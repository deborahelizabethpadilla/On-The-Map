//
//  Network.swift
//  OnTheMap2
//
//  Created by Deborah on 2/15/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import UIKit

class UdacityNetwork: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override init() {
        super.init()
    }
    
    //Udacity Log In
    
    func getUdacityData(username: String, password: String, completionHandlerForAuth: @escaping (_ success: Bool,_ errormsg: String?, _ error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://www.udacity.com/api/session")! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func handleError(error: String, errormsg: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForAuth(false, errormsg, NSError(domain: "getUdacityData", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                handleError(error: "There was an error with your request: \(error)", errormsg: self.appDelegate.errorMessage.CantLogin)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                handleError(error: "Your request returned a status code other than 2xx!", errormsg: self.appDelegate.errorMessage.InvalidEmail)
                return
            }
            
            guard let data = data else {
                handleError(error: "No data was returned by the request!", errormsg: self.appDelegate.errorMessage.CantLogin)
                return
            }
            
            //Parse Data
            
            let stringData = String(data: data, encoding: String.Encoding.utf8)
            print(stringData ?? "mali din")
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            let stringnewData = String(data: newData, encoding: String.Encoding.utf8)
            print(stringnewData ?? "mali!")
            
            let parsedResult = try? JSONSerialization.jsonObject(with: newData, options: .allowFragments)
            
            guard let dictionary = parsedResult as? [String: Any] else {
                handleError(error: "Cannot parse dictionary", errormsg: self.appDelegate.errorMessage.CantLogin)
                return
            }
            
            guard let account = dictionary["account"] as? [String:Any] else {
                handleError(error: "Cannot find key 'account' in \(parsedResult)", errormsg: self.appDelegate.errorMessage.CantLogin)
                return
            }
            
            //Utilize Data
            
            guard let userID = account["key"] as? String else {
                handleError(error: "Cannot find key 'key' in \(account)", errormsg: self.appDelegate.errorMessage.CantLogin)
                return
            }
            
            self.appDelegate.userID = userID
            
            completionHandlerForAuth(true, nil, nil)
        }
        
        task.resume()
        
    }
    
    func getUserData(userID: String, completionHandlerForAuth: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://www.udacity.com/api/users/\(userID)")! as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForAuth(false, NSError(domain: "getUserData", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            //Parse Data
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            
            let parsedResult: Any!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments)
            } catch {
                sendError(error: "Could not parse the data as JSON: '\(data)'")
                return
            }
            
            guard let dictionary = parsedResult as? [String: Any] else {
                sendError(error: "Cannot parse")
                return
            }
            
            
            guard let user = dictionary["user"] as? [String: Any] else {
                sendError(error: "Cannot find key 'user' in \(parsedResult)")
                return
            }
            
            guard let lastName = user["last_name"] as? String else {
                sendError(error: "Cannot find key 'key' in \(user)")
                return
            }
            
            //Utilize Data
            
            guard let firstName = user["first_name"] as? String else {
                sendError(error: "Cannot find key 'key' in \(user)")
                return
            }
            self.appDelegate.lastName = lastName
            self.appDelegate.firstName = firstName
            completionHandlerForAuth(true, nil)
        }
        task.resume()
    }
    
    func getUsersData(completionHandlerForData: @escaping (_ success: Bool, _ error: NSError?) -> Void) -> Void {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation?order=-updatedAt&limit=100")! as URL)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForData(false, NSError(domain: "getStudentData", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            //Parse Data
            let parsedResult: Any!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            } catch {
                sendError(error: "Could not parse the data as JSON: '\(data)'")
                return
            }
            
            if let results = parsedResult as? [String: Any] {
                if let resultSet = results["results"] as? [[String: Any]]{
                    UsersInfo.UsersArray = UsersInfo.studentDataFromResults(resultSet)
                    print("yehey? \(UsersInfo.UsersArray)")
                    completionHandlerForData(true, nil)
                }
            } else {
                sendError(error: "sorry change me")
            }
            
        }
        task.resume()
    }
    
    func isExisting(uniqueKey: String) {
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?where=%7B%22uniqueKey%22%3A%22\(uniqueKey)%22%7D"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            guard (error == nil) else {
                self.appDelegate.willOverwrite = false
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                self.appDelegate.willOverwrite = false
                return
            }
            
            guard let data = data else {
                self.appDelegate.willOverwrite = false
                return
            }
            
            let parsedResult: Any!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            if let results = parsedResult as? [String: Any] {
                if let resultSet = results["results"] as? [[String: Any]]{
                    
                    let student =  UsersInfo.studentDataFromResults(resultSet)[0]
                    self.appDelegate.willOverwrite = true
                    self.appDelegate.firstName = student.firstName
                    self.appDelegate.lastName = student.lastName
                    self.appDelegate.objectId = student.objectId
                    self.appDelegate.uniqueKey = student.uniqueKey
                    
                }
            }
            
        }
        task.resume()
    }
    
    func logoutID(controller: UIViewController) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://www.udacity.com/api/session")! as URL)
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
            
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            guard data != nil else {
                print("No data was returned by the request!")
                return
            }
            print("Logged out")
        }
        task.resume()
    }
    
    //Post Functions
    
    func postNew(student: UsersInfo, location: String, completionHandlerForPost: @escaping (_ success: Bool, _ error: NSError?)->Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")! as URL)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(student.uniqueKey)\", \"firstName\": \"\(student.firstName)\", \"lastName\": \"\(student.lastName)\",\"mapString\": \"\(location)\", \"mediaURL\": \"\(student.mediaURL)\",\"latitude\": \(student.lat), \"longitude\": \(student.long)}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPost(false, NSError(domain: "postNewStudentData", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            
            guard data != nil else {
                sendError(error: "No data was returned by the request!")
                return
            }
            completionHandlerForPost(true, nil)
        }
        task.resume()
        
    }
    
    func updateStudentData(student: UsersInfo, location: String, completionHandlerForPut: @escaping (_ success: Bool, _ error: NSError?)->Void) {
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation\(student.objectId)"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(student.uniqueKey)\", \"firstName\": \"\(student.firstName)\", \"lastName\": \"\(student.lastName)\",\"mapString\": \"\(location)\", \"mediaURL\": \"\(student.mediaURL)\",\"latitude\": \(student.lat), \"longitude\": \(student.long)}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPut(false, NSError(domain: "updateStudentData", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            guard data != nil else {
                sendError(error: "No data was returned by the request!")
                return
            }
            completionHandlerForPut(true, nil)
        }
        task.resume()
        
    }
    
    //Shared Instance
    
    class func sharedInstance() -> UdacityNetwork {
        struct Singleton {
            static var sharedInstance = UdacityNetwork()
        }
        return Singleton.sharedInstance
    }
}


