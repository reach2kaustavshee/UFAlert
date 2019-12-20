//
//  UFAlert.swift
//  UFAlert
//
//  Created by Kaustav Shee on 23/11/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import Foundation
import UIKit

/// This is an Alert Display short class
open class UFAlert {
    
    /// This is the structure that is the action handler object
    public struct ActionHandler {
        
        /// This is the name of the action
        public var actionName:String
        
        /// This is the optional handler we can attach with the action
        public var handler:(()->())?
        
        /// This is the UIAlertAction style
        public var style:UIAlertAction.Style
        
        /// This is the default initialzer for the Action Handler
        ///
        /// - Parameters:
        ///   - actionName: name of the action
        ///   - handler: handler for the action
        ///   - style: style of the action
        public init(_ actionName:String,_ style:UIAlertAction.Style,_ handler:(()->())?) {
            self.actionName = actionName
            self.handler = handler
            self.style = style
        }
    }
    
    fileprivate static let bundleIdentifier = "ks.com.UFAlert"
    
    
    /// This method will display alert and action sheet from either view controller or from window's root view controller
    ///
    /// - Parameters:
    ///   - vc: This is the view controller from which the alert will be displayed (Optional)
    ///   - msg: This is the message would be displayed on the alert or action sheet (Optional)
    ///   - header: This is the title of the alert or action sheet (Optional)
    ///   - actionStyle: This is the style whether it is a alert or a action sheet (Default value: .alert)
    ///   - handlers: This is the array of handlers for all customized action (Optional)
    ///   - alertControllerPresented: This clouser will execute during the alert presented (Optional)
    ///   - alertControllerDismissed: This clouser will execute during the alert dismissed (Optional)
    open class func displayAlert(fromViewController vc:UIViewController? = UIApplication.shared.keyWindow?.rootViewController, withMessage msg:String?, Header header:String?, _ actionStyle:UIAlertController.Style = .alert,Handlers handlers:[ActionHandler]? = nil,FromView fromView:UIView?, FromBounds bounds:CGRect?,_ alertControllerPresented:(()->())? = nil,_ alertControllerDismissed:(()->())? = nil) {
        let alertController = UIAlertController(title: header, message: msg, preferredStyle: actionStyle)
        if let allHandlers = handlers, allHandlers.count > 0 {
            for handler in allHandlers {
                let action = UIAlertAction(title: handler.actionName, style: handler.style) { (action:UIAlertAction) in
                    handler.handler?()
                }
                alertController.addAction(action)
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(50)) {
                alertController.dismiss(animated: true, completion: {
                    alertControllerDismissed?()
                })
            }
        }
        if let popoverPresentationController = alertController.popoverPresentationController  {
            guard
                let fromView = fromView,
                let bounds = bounds
                else { return }
            popoverPresentationController.sourceView = fromView
            popoverPresentationController.sourceRect = bounds
        }
        vc?.present(alertController, animated: true, completion: {
            alertControllerPresented?()
        })
    }
    
    /// This will display the toast message on the specified view
    /// - Parameters:
    ///   - view: This is the view in which toast will be displayed, generally it would be self.view
    ///   - msg: This a string taking the message to be displayed
    ///   - duration: This is the duration till which the toast message will be displayed, after that the toast will be dismissed
    ///   - bgcolor: This is the background color of the toast message
    ///   - textColor: This is the text color of the toast message
    ///   - alpha: this is the alpha component of the background color
    open class func displayToastMessage(OnView view:UIView, Message msg:String?,Duration duration:DispatchTimeInterval = DispatchTimeInterval.seconds(2),Background bgcolor:UIColor = UIColor.black, TextColor textColor:UIColor = UIColor.white, AlphaComponentOfBAckground alpha:CGFloat = 0.75) {
        
        guard let msg = msg, !(msg.isEmpty) else { return }
        
        
        let label = UFPaddingLabel()
        label.textColor = textColor
        label.backgroundColor = bgcolor.withAlphaComponent(alpha)
        label.layer.cornerRadius = 7.0
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = msg
        
        view.addSubview(label)
        
//        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
        label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20.0).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20.0).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+duration) {
            label.removeFromSuperview()
        }
    }
    
    /// This will display the message as a banner will be displayed automatically after specified duration
    /// - Parameters:
    ///   - bgColor: This is the background color of the banner
    ///   - textColor: this is the text color of the banner
    ///   - strTitle: this is the title of the banner
    ///   - strShortDescription: this is the short description
    ///   - image: This is the optional image which would be displayed as a thumb on the left side of the banner`
    ///   - bannerHeight: This is the height of the banner
    open class func displayBanner(withBackgroundColor bgColor:UIColor = .lightGray, TextColor textColor:UIColor = .white, Title strTitle:String? = nil, ShortDescription strShortDescription:String? = nil,Image image:UIImage? = nil, BannerHeight bannerHeight:CGFloat = 65.0) {
        
        func setupProperties(forBannerView banner:UFBannerView, BackgroundColor bgColor:UIColor = .lightGray, TextColor textColor:UIColor = .white, Title strTitle:String? = nil, ShortDescription strShortDescription:String? = nil,Image image:UIImage? = nil) {
            banner.view.backgroundColor = bgColor
            banner.lblTitle.text = strTitle
            banner.lblShortDescription.text = strShortDescription
            if let img = image {
                banner.imgLeft.image = img
                banner.viewImageContainer.isHidden = false
            }else{
                banner.imgLeft.image = nil
                banner.viewImageContainer.isHidden = true
            }
            banner.lblTitle.textColor = textColor
            banner.lblShortDescription.textColor = textColor
        }
        
        let banner = UFBannerView(frame: CGRect(x: 10.0, y: -100.0, width: (UIScreen.main.bounds.size.width - 20.0), height: 50.0))
        banner.layer.cornerRadius = 7.0
        banner.layer.masksToBounds = true
        banner.view.backgroundColor = .green
        
        UIApplication.shared.keyWindow?.addSubview(banner)
        
        let leading = NSLayoutConstraint(item: banner, attribute: .leading, relatedBy: .equal, toItem: UIApplication.shared.keyWindow!, attribute: .leading, multiplier: 1.0, constant: 10.0)
        leading.identifier = "identifier KS 10"
        let trailing = NSLayoutConstraint(item: banner, attribute: .trailing, relatedBy: .equal, toItem: UIApplication.shared.keyWindow!, attribute: .trailing, multiplier: 1.0, constant: -10.0)
        trailing.identifier = "identifier KS 11"
        let top = NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: UIApplication.shared.keyWindow!, attribute: .top, multiplier: 1.0, constant: -100.0)
        top.identifier = "identifier KS 12"

        UIApplication.shared.keyWindow?.addConstraints([leading,trailing,top])
        
        let consHeight = NSLayoutConstraint(item: banner, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: bannerHeight)
        consHeight.identifier = "identifier KS 13"
        banner.addConstraint(consHeight)
        
        UIView.animate(withDuration: 0.0, animations: {
            UIApplication.shared.keyWindow?.layoutIfNeeded()
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.milliseconds(10)) {
            top.constant = UIApplication.shared.statusBarFrame.height
            UIView.animate(withDuration: 0.3, animations: {
                UIApplication.shared.keyWindow?.layoutIfNeeded()
            })
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(3)) {
            top.constant = -100.0
            UIView.animate(withDuration: 0.3, animations: {
                UIApplication.shared.keyWindow?.layoutIfNeeded()
            })
        }
        setupProperties(forBannerView: banner, BackgroundColor: bgColor, TextColor: textColor, Title: strTitle, ShortDescription: strShortDescription, Image: image)
    }
    
    open class func displayCustomPopover(fromViewController vc:UIViewController? = UIApplication.shared.keyWindow?.rootViewController, withMessage msg:String?, Header header:String?, FromView fromView:UIView?, FromBounds bounds:CGRect?,_ preferedContentSize:CGSize,_ alertControllerPresented:(()->())? = nil,_ alertControllerDismissed:(()->())? = nil) {
        
        let bundle = Bundle(identifier: bundleIdentifier)
        let pop = UFPopoverBaseViewController(nibName: String(describing: UFPopoverBaseViewController.self), bundle: bundle)
        pop.modalPresentationStyle = .popover
        pop.preferredContentSize = preferedContentSize
        if let pres = pop.presentationController {
            pres.delegate = pop
        }
        if let popover: UIPopoverPresentationController = pop.popoverPresentationController {
            popover.sourceView = fromView
            popover.sourceRect = bounds!
        }
        vc?.present(pop, animated: true, completion:nil)
    }
    
    deinit {
        debugPrint("UFAlert Deinit")
    }
}
