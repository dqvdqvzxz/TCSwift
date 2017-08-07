//
//  TRCCity.swift
//  ToricareSwift
//
//  Created by tuan on 8/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation

struct TRCCity
{
    var name: String
    var cityId: String
    var cityCode: String
    
    init(name aName: String, cityId aCityId: String, cityCode aCityCode: String) {
        name = aName
        cityId = aCityId
        cityCode = aCityCode
    }

}

extension TRCCity: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.name = try decoder.value(forKey: NAME)
        self.cityId = try decoder.value(forKey: CITY_ID)
        self.cityCode = try decoder.value(forKey: CITY_CODE)
    }
}
