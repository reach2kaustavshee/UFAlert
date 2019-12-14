//
//  ViewController.swift
//  UFAlertEG
//
//  Created by Kaustav Shee on 14/12/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import UIKit
import UFAlert

class TableCellDemo:UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var tblDisplay:UITableView! {
        didSet {
            tblDisplay.tableFooterView = UIView()
        }
    }
    
    var plistData: [String] = [] //Our data

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadPlist()
    }
    
    private func loadPlist() {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        
        let plistPath: String? = Bundle.main.path(forResource: "Item", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String]
            tblDisplay.reloadData()
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plistData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = plistData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.plistData[indexPath.row].contains("Alert") {
            displayAlert()
        }
        else if self.plistData[indexPath.row].contains("Action") {
            displayActionSheet()
        }
        else if self.plistData[indexPath.row].contains("Banner") {
            displayBanner()
        }
        else if self.plistData[indexPath.row].contains("Toast") {
            displayToast()
        }
    }
    
    private func displayAlert() {
        let actionOK = UFAlert.ActionHandler("OK", .default) {
                debugPrint("OK Pressed")
        }
        UFAlert.displayAlert(fromViewController: self, withMessage: "Message Body", Header: "Title", .alert, Handlers: [actionOK], FromView: nil, FromBounds: nil, nil, nil)
    }
    
    private func displayActionSheet() {
        let actionOK = UFAlert.ActionHandler("OK", .default) {
                debugPrint("OK Pressed")
        }
        UFAlert.displayAlert(fromViewController: self, withMessage: "Message Body", Header: "Title", .actionSheet, Handlers: [actionOK], FromView: nil, FromBounds: nil, nil, nil)
    }

    private func displayBanner() {
        UFAlert.displayBanner(withBackgroundColor: .black, TextColor: .white, Title: "Title", ShortDescription: "Description to be displayed on the banner", Image: nil, BannerHeight: 65.0)
    }
    
    private func displayToast() {
        UFAlert.displayToastMessage(OnView: self.view, Message: "Hello world")
    }
}



