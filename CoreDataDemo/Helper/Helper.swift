//
//  Helper.swift
//  CoreDataDemo
//
//  Created by nikunj on 14/03/20.
//  Copyright © 2020 Nikul. All rights reserved.
//

import UIKit

class Helper: NSObject {
}

extension UILabel {
    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = .center
        let attributedString: NSMutableAttributedString
        if let labelattributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

        attributedText = attributedString
    }
}

extension UIView {
    func setViewShadow(clr: UIColor) {
        dropShadow(color: clr, opacity: 0.3, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        //   layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension CGSize {
    func resizeFill(toSize: CGSize) -> CGSize {
        let scale: CGFloat = (height / width) < (toSize.height / toSize.width) ? (height / toSize.height) : (width / toSize.width)
        return CGSize(width: width / scale, height: height / scale)
    }
}

extension UIImage {
    func scale(toSize newSize: CGSize) -> UIImage {
        // make sure the new size has the correct aspect ratio
        let aspectFill = size.resizeFill(toSize: newSize)

        UIGraphicsBeginImageContextWithOptions(aspectFill, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: aspectFill.width, height: aspectFill.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
}
