//
//  TableViewController.swift
//  OnTheMap2
//
//  Created by Deborah on 2/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let reuseIdentifier = "infoCell"
    
    let returnActionTitle = "Return"
    let invalidLinkProvidedMessage = "Oh No! Can't Open Link!"
    let badLinkTitle = "Oh No! Bad URL!"
    let parseRetrievalFailedTitle = "No Data!"
    
    override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let numberofPeople = StudentInfoController.people.count
    return numberofPeople
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for:  indexPath)
    let studentInfo = StudentInfoController.people[indexPath.row]
    cell.textLabel?.text = "\(studentInfo.firstName) \(studentInfo.lastName)"
    cell.detailTextLabel?.text = "\(studentInfo.mediaURL)"
        
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    let app = UIApplication.shared
        
    guard let providedURL = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text,
    let url = URL(string: providedURL), app.openURL(url) == true else {
                
    let alertViewMessage = invalidLinkProvidedMessage
    let alertActionTitle = returnActionTitle
                
    presentAlert(badLinkTitle, message: alertViewMessage, actionTitle: alertActionTitle)
    return
                
    }
    }
    }

