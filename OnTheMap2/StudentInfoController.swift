//
//  StudentInfoController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation

let StudentInfoUpdated = "StudentInfoUpdated"

    struct StudentInfoController {
    
    static let createdAtKey = "createdAt"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let latitudeKey = "latitude"
    static let longitudeKey = "longitude"
    static let mapStringKey = "mapString"
    static let mediaURLKey = "mediaURL"
    static let objectIdKey = "objectId"
    static let uniqueKeyKey = "uniqueKey"
    static let updatedAtKey = "updatedAt"
    static var people = [StudentInfo]()
    
    static func studentList(withStudents newStudents: [[String: AnyObject]]) {
    people.removeAll()
        
    for firststudent in newStudents {
    let newStudent = StudentInfo(peopleInfo: firststudent)
    StudentInfoController.people.append(newStudent)
            
    }
        
    let note = Notification(name: Notification.Name(rawValue: StudentInfoUpdated), object: nil)
    NotificationCenter.default.post(note)
        
    }
    }
