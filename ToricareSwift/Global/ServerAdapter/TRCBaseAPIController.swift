//
//  TRCAPIController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import Alamofire

class TRCBaseAPIController{
    class func postAPI(_ params: Dictionary<String, String>, atPath path:String, withMethod httpMethod:String, blockCompletion completion:@escaping (_ data: NSDictionary?) -> (), blockFailed failed:@escaping (_ error:String?)->()){
        
        if Connectivity.isConnectToNetwork() == false{
            Alert(title: kNetworkDisable)
        }else{
            let urls = "\(APP_DOMAIN)\(path)"
//            let urls = "http://private-855d6c-ilovestayadmin.apiary-mock.com/getUserList?status=approval"
            
            if let url = URL(string: urls){
                var urlRequest = URLRequest(url: url)
                
                //http method
                switch httpMethod {
                case HTTP_POST:
                    urlRequest.httpMethod = HTTP_POST
                    do { urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])} catch {}
                case HTTP_PUT:
                    urlRequest.httpMethod = HTTP_PUT
                    do { urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])} catch {}
                case HTTP_GET:
                    urlRequest.httpMethod = HTTP_GET
                case HTTP_DELETE:
                    urlRequest.httpMethod = HTTP_DELETE
                default:
                    break
                }
                
                //header
                urlRequest.setValue(HEADER_AUTHORIZATION, forHTTPHeaderField: "Authorization")
                
                Alamofire.request(urlRequest).responseJSON { (response) in

                    switch response.result{
                    case .success:
                        //block
                        if let statusCode = response.response?.statusCode{
                            if statusCode == 200{
                                if let json = response.result.value{
                                    DLog("JSON: \(json)")
                                }
                            }
                        }
                        DLog("Validation Successfull !")
                    case .failure(_):
                        //block
                        if let statusCode = response.response?.statusCode{
                            ELog("Status code: \(statusCode)")
                            if statusCode == 400{
                                //handle
                            }
                        }
                    }
                }
            }else{
                Alert(title: kParamInvalid)
            }
        }
    }
}
