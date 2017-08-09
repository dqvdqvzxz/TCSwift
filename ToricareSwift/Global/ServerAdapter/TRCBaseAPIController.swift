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
    func callAPI(_ params: Dictionary<String, String>, atPath path:String, withMethod httpMethod:String, blockCompletion completion:@escaping (_ data: NSDictionary?) -> (), blockFailed failed:@escaping (_ error: String?)->()){
    
        if Connectivity.isConnectToNetwork() == false{
            failed(STRING_CHECK_NETWORK)
        }else{
            //url
            let urls = "\(APP_DOMAIN)\(path)"
            if let url = URL(string: urls){
                var urlRequest = URLRequest(url: url)
                
                switch httpMethod {
                case HTTP_POST:
                    urlRequest.httpMethod = HTTP_POST
                    break
                case HTTP_PUT:
                    urlRequest.httpMethod = HTTP_PUT
                    break
                case HTTP_GET:
                    urlRequest.httpMethod = HTTP_GET
                    break
                case HTTP_DELETE:
                    urlRequest.httpMethod = HTTP_DELETE
                    break
                default:
                    failed("Method is invalid !")
                    break
                }

                //header
                urlRequest.addValue(HEADER_AUTHORIZATION, forHTTPHeaderField: AUTHORIZATION)
                urlRequest.addValue(HEADER_CONTENT_TYPE, forHTTPHeaderField: CONTENT_TYPE)
                if(UserDefaults.getUD(ACCESS_TOKEN) != nil){
                    urlRequest.addValue(UserDefaults.getUD(ACCESS_TOKEN) as! String, forHTTPHeaderField: X_ACCESS_TOKEN)
                }

                do{
                    //parameter
                    let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
                    
                    Alamofire.request(encodedURLRequest).responseJSON { (response) in
                        let data = response.result.value as? NSDictionary
                        
                        DLog(data)
                        
                        //handle status code
                        let statusCode = response.response?.statusCode
                        
                        if (statusCode == STATUS_CODE_NO_CONTENT) {
                            failed(RESULT_NO_DATA)
                            return
                        } else if (statusCode == STATUS_CODE_SUCCESS) {
                            completion(data)
                            return
                        } else {
                            //handle result fail
                            if let resultFail = data?.object(forKey: "errors") as? NSArray{
                                for index in 0...resultFail.count-1{
                                    let indexMessage = resultFail[index] as! NSDictionary
                                    let message = indexMessage["message"]
                                    failed(message as? String)
                                    return
                                }
                            }
                        }
                    }
                }catch{
                    failed("error")
                }
            }else{
                failed(STRING_CHECK_INPUT_DATA)
            }
        }
    }
}
