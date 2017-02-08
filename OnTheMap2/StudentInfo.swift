//
//  StudentInfo.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation

struct StudentInfo {
    
    var createdAt: String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var objectId: String
    var uniqueKey: String
    var updatedAt: String
    
    init(peopleInfo: [String: AnyObject]) {
    createdAt = peopleInfo[StudentInfoController.createdAtKey] != nil ? peopleInfo[StudentInfoController.createdAtKey] as! String : ""
    firstName = peopleInfo[StudentInfoController.firstNameKey] as! String
    lastName  = peopleInfo[StudentInfoController.lastNameKey]  as! String
    latitude  = peopleInfo[StudentInfoController.latitudeKey]  as! Double
    longitude = peopleInfo[StudentInfoController.longitudeKey] as! Double
    mapString = peopleInfo[StudentInfoController.mapStringKey] as! String
    mediaURL = peopleInfo[StudentInfoController.mediaURLKey]  as! String
    objectId  = peopleInfo[StudentInfoController.objectIdKey] != nil ? peopleInfo[StudentInfoController.objectIdKey] as! String : ""
    uniqueKey = peopleInfo[StudentInfoController.uniqueKeyKey] as! String
    updatedAt = peopleInfo[StudentInfoController.updatedAtKey] != nil ? peopleInfo[StudentInfoController.updatedAtKey] as! String : ""
        
    }
    
    }
