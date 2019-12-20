//
//  PaddingLabel.swift
//  UFAlert
//
//  Created by Kaustav Shee on 14/12/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import UIKit

@IBDesignable open class UFPaddingLabel: UILabel {

    @IBInspectable open var topInset: CGFloat = 5.0
    @IBInspectable open var bottomInset: CGFloat = 5.0
    @IBInspectable open var leftInset: CGFloat = 7.0
    @IBInspectable open var rightInset: CGFloat = 7.0

    override open func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override open var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
