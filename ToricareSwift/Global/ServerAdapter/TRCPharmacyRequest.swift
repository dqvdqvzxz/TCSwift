//
//  TRCPharmacyRequest.swift
//  ToricareSwift
//
//  Created by tuan on 8/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPharmacyRequest: TRCBaseAPIController {
    func searchPharmacy(_ pharmacySearchData: TRCPharmacySearchData, _ pageNumber: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        var parameters = Dictionary <String, String>()
        parameters[PREFECTURE_ID] = pharmacySearchData.prefectureId
        parameters[CITY_ID] = pharmacySearchData.cityId
        parameters[SHOP_NAME] = pharmacySearchData.shopName
        parameters[LAT] = pharmacySearchData.lat
        parameters[LONG] = pharmacySearchData.long
        parameters[PAGE] = pageNumber
        
        self.callAPI(parameters, atPath: "\(URL_SHOPS)", withMethod: HTTP_GET, blockCompletion: { (data) in
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func registerPharmacy(_ shopId: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        var parameters = Dictionary <String, String>()
        parameters[SHOP_ID] = shopId
        
        self.callAPI(parameters, atPath: "\(URL_MEMBERS_SHOPS)", withMethod: HTTP_POST, blockCompletion: { (data) in
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }

    func getPharmacy(_ shopId: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        self.callAPI(Dictionary(), atPath: URL_SHOPS + "/" + shopId , withMethod: HTTP_GET, blockCompletion: { (data) in
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }

}
