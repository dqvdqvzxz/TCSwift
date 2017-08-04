//
//  TRCCityObject.swift
//  ToricareSwift
//
//  Created by tuan on 8/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCCityObject: NSObject {
    var name = ""
    var cityId = ""
    var cityCode = ""
    
    func parse(_ data: Array<Any>?) -> NSMutableArray{
        let cityArray = NSMutableArray()
        if (data != nil) {
            for dataDict in data! {
                let object = TRCCityObject()
                if (Global().isNotNull((dataDict as! NSDictionary).object(forKey: NAME))) {
                    object.name = (dataDict as! NSDictionary).object(forKey: NAME) as! String
                }
                if (Global().isNotNull((dataDict as! NSDictionary).object(forKey: CITY_ID))) {
                    object.cityId = Global().convertObjectToString((dataDict as! NSDictionary).object(forKey: CITY_ID))
                }
                if (Global().isNotNull((dataDict as! NSDictionary).object(forKey: CITY_CODE))) {
                    object.cityCode = (dataDict as! NSDictionary).object(forKey: CITY_CODE) as! String
                }

                cityArray.add(object)
            }
        }
        
        return cityArray
    }

}
