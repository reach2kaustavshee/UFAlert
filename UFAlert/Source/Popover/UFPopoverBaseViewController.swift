//
//  PopoverBaseViewController.swift
//  UFAlert
//
//  Created by Kaustav Shee on 15/12/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import UIKit

class UFPopoverBaseViewController: UIViewController {
    
    @IBOutlet var vwTitle:UIView!
    
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblDescription:UILabel!
    
    @IBOutlet var tblDisplay:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension UFPopoverBaseViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

