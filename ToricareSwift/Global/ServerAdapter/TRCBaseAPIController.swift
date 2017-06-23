//
//  TRCAPIController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import Alamofire

func sendParams(_ params: Dictionary<String, String>, atPath path:String, blockCompletion completion:@escaping (_ data: NSDictionary?) -> (), blockFailed failed:@escaping (_ error:String?)->()){
    
    let urls = "\(APP_DOMAIN)\(path)"
    
    let headers = [
        "Authorization" : ""
    ]
    
    if let _ = URL(string: urls){
        Alamofire.request("https://httpbin.org/get", method: HTTPMethod.post, parameters: params, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).validate().responseJSON { (response) in
            
            switch response.result{
            case .success:
                if let json = response.result.value{
                    print("JSON: \(json)") //serialized json response
                }
                print("Validation Successfull !")
            case .failure(let error):
                print(error)
            }
        }
    }
}

