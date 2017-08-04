//
//  TRCPharmacyRequest.swift
//  ToricareSwift
//
//  Created by tuan on 8/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPharmacyRequest: TRCBaseAPIController {
    func searchPharmacy(_ pharmacySearchData: TRCPharmacySearchData, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        var parameters = Dictionary <String, String>()
        parameters[PREFECTURE_ID] = pharmacySearchData.prefectureId
        parameters[CITY_ID] = pharmacySearchData.cityId
        parameters[SHOP_NAME] = pharmacySearchData.shopName

        self.callAPI(parameters, atPath: "\(URL_SHOPS)", withMethod: HTTP_GET, blockCompletion: { (data) in
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
