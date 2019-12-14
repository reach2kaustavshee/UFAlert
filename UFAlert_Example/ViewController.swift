//
//  ViewController.swift
//  UFAlert_Example
//
//  Created by Kaustav Shee on 15/12/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import UIKit
import UFAlert

class ViewController: UIViewController {
    
    
    enum Feature:String,CaseIterable {
        case alert = "Alert"
        case actionSheet = "Action Sheet"
        case banner = "Banner"
        case toast = "Toast"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.Feature.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = ViewController.Feature.allCases[indexPath.row].rawValue
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let val = ViewController.Feature.allCases[indexPath.row]
        switch val {
        case .alert:
            displayAlert()
        case .actionSheet:
            displayActionSheet()
        case .banner:
            displayBanner()
        case .toast:
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

