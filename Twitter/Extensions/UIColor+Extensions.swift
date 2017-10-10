//
//  UIColor+Extensions.swift
//  Twitter
//
//  Created by Thanh Nguyen Xuan on 10/9/17.
//  Copyright © 2017 Thanh Nguyen Xuan. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(gray: Int) {
        self.init(red: CGFloat(gray) / 255.0, green: CGFloat(gray) / 255.0, blue: CGFloat(gray) / 255.0, alpha: 1.0)
    }

    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

}
