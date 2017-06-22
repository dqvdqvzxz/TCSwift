//
//  UIColor+HexColor.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(hexString:  String){
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        
        var RGBValue: UInt64 = 0
        
        scanner.scanHexInt64(&RGBValue)
        
        let R = (RGBValue & 0xff0000) >> 16
        let G = (RGBValue & 0xff00) >> 8
        let B = (RGBValue & 0xff)
        
        self.init(
            red: CGFloat(R) / 0xff,
            green: CGFloat(G) / 0xff,
            blue: CGFloat(B) / 0xff,
            alpha: 1
        )
    }
    
    convenience init(hexString:  String, alpha: Double){
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        
        var RGBValue: UInt64 = 0
        
        scanner.scanHexInt64(&RGBValue)
        
        let R = (RGBValue & 0xff0000) >> 16
        let G = (RGBValue & 0xff00) >> 8
        let B = (RGBValue & 0xff)
        
        self.init(
            red: CGFloat(R) / 0xff,
            green: CGFloat(G) / 0xff,
            blue: CGFloat(B) / 0xff,
            alpha: CGFloat(alpha)
        )
    }
}
