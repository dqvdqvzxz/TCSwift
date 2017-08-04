//
//  TRCPrefecturesObject.swift
//  ToricareSwift
//
//  Created by tuan on 8/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPrefecturesObject: NSObject {
    var name = ""
    var prefectureId = ""
    
    func parse(_ data: Array<Any>?) -> NSMutableArray{
        let prefectureArray = NSMutableArray()
        if (data != nil) {
            for dataDict in data! {
                let object = TRCPrefecturesObject()
                object.name = (dataDict as! NSDictionary).object(forKey: NAME) as! String
                object.prefectureId = (dataDict as! NSDictionary).object(forKey: PREFECTURE_ID) as! String
                prefectureArray.add(object)
            }
        }
        
        return prefectureArray
    }
}
