//
//  Image.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UIImageView{
    override func makeCircle(){
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func makeBorder(){
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
