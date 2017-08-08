//
//  TRCPharmacistRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/8/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPharmacistRequest: TRCBaseAPIController {
    func PharmacistInfoCreate(_ name: String, _ tel: String, _ email: String, _ note: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters["name"] = name
        parameters["tel"] = tel
        parameters["email"] = email
        parameters["note"] = note
        
        self.callAPI(parameters, atPath: "\(URL_PHARMACIST_INFO)", withMethod: HTTP_POST, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func PharmacistInfoChange(_ name: String, _ tel: String, _ email: String, _ note: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters["name"] = name
        parameters["tel"] = tel
        parameters["email"] = email
        parameters["note"] = note
        
        self.callAPI(parameters, atPath: "\(URL_PHARMACIST_INFO)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func PharmacistInfo(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_PHARMACIST_INFO)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
