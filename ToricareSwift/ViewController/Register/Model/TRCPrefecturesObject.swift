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
                if (Global().isNotNull((dataDict as! NSDictionary).object(forKey: NAME))) {
                    object.name = (dataDict as! NSDictionary).object(forKey: NAME) as! String
                }
                if (Global().isNotNull((dataDict as! NSDictionary).object(forKey: PREFECTURE_ID))) {
                    object.prefectureId = Global().convertObjectToString((dataDict as! NSDictionary).object(forKey: PREFECTURE_ID))
                }
                prefectureArray.add(object)
            }
        }
        
        return prefectureArray
    }
}
