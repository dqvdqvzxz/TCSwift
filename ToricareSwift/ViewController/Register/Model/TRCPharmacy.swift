//
//  TRCPharmacy.swift
//  ToricareSwift
//
//  Created by tuan on 8/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation

struct TRCPharmacy
{
    var pharmacyId: String
    var shopGroupId: String
    var posGroupId: String
    var pharmacyCode: String
    
    var name: String
    var postCode1: String
    var postCode2: String
    
    var cityId: String
    var address1: String
    var address2: String

    var latlon: String
//    var long: NSNumber
    
    var tel: String
    var businessHours: String
    var holiday: String
    var url: String
    
    var images: [TRCImage]
}

extension TRCPharmacy: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.pharmacyId = try decoder.value(forKey: ID)
        self.shopGroupId = try decoder.value(forKey: SHOP_GROUP_ID)
        self.posGroupId = try decoder.value(forKey: POS_SHOP_ID)
        self.pharmacyCode = try decoder.value(forKey: PHARMACY_CODE)
        
        self.name = try decoder.value(forKey: NAME)
        self.postCode1 = try decoder.value(forKey: POST_CODE1)
        self.postCode2 = try decoder.value(forKey: POST_CODE2)
        
        self.cityId = try decoder.value(forKey: CITY_ID)
        self.address1 = try decoder.value(forKey: ADDRESS1)
        self.address2 = try decoder.value(forKey: ADDRESS2)
        
        self.latlon = try decoder.value(forKey: LATLON)
        
        self.tel = try decoder.value(forKey: TEL)
        self.businessHours = try decoder.value(forKey: BUSSINESS_HOURS)
        self.holiday = try decoder.value(forKey: HOLIDAY)
        self.url = try decoder.value(forKey: URL_KEY)
        self.images = try decoder.valueImages(forKey: IMAGES)
    }
}
