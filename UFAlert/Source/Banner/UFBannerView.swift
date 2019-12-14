//
//  UFBannerView.swift
//  UFAlert
//
//  Created by Kaustav Shee on 24/11/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import UIKit

class UFBannerView: UIView {
    
    var view:UIView!
    var viewImageContainer:UIView!
    var lblTitle:UILabel!
    var lblShortDescription:UILabel!
    var imgLeft:UIImageView!

    internal override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setup()
    }
    
    internal convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func setup() {
        let bundle = Bundle(for: type(of: self))
        guard let bannerView = bundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return }
        self.view = bannerView
        
        self.translatesAutoresizingMaskIntoConstraints = false
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        let consLeading = NSLayoutConstraint(item: bannerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        consLeading.identifier = "identifier KS 1"
        let consTrailing = NSLayoutConstraint(item: bannerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        consTrailing.identifier = "identifier KS 2"
        let consTop = NSLayoutConstraint(item: bannerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        consTop.identifier = "identifier KS 3"
        let consBottom = NSLayoutConstraint(item: bannerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        consBottom.identifier = "identifier KS 4"
        
        bannerView.frame = self.bounds
        self.addSubview(bannerView)
        
        self.addConstraints([consLeading,consTrailing,consTop,consBottom])
        
        loadAllSubviews()
    }
    
    private func loadAllSubviews() {
        if let vw = self.view.viewWithTag(103) {
            self.viewImageContainer = vw
        }
        if let img = self.view.viewWithTag(100) as? UIImageView {
            self.imgLeft = img
        }
        if let lbl = self.view.viewWithTag(101) as? UILabel {
            self.lblTitle = lbl
        }
        if let lbl = self.view.viewWithTag(102) as? UILabel {
            self.lblShortDescription = lbl
        }
    }
    
    deinit {
        debugPrint("UFBannerView deinit")
    }
}
