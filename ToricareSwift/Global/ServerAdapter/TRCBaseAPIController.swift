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
    class func callAPI(_ params: Dictionary<String, String>, atPath path:String, withMethod httpMethod:String, blockCompletion completion:@escaping (_ data: NSDictionary?) -> (), blockFailed failed:@escaping (_ data: NSDictionary?)->()){
    
        if Connectivity.isConnectToNetwork() == false{
//            failed(Alert(title: STRING_CHECK_NETWORK))
        }else{
            let urls = "\(APP_DOMAIN)\(path)"
            if(path == ""){
//                failed(ELog("URL is not exist !"))
            }
            
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
//                    failed(ELog("Method is invalid !"))
                    break
                }

                //header
                urlRequest.setValue(HEADER_AUTHORIZATION, forHTTPHeaderField: "Authorization")
                if((urlRequest.value(forHTTPHeaderField: "Authorization")) == nil){
//                    failed(ELog("Header of request HTTP is invalid !"))
                }
                
                Alamofire.request(urlRequest).responseJSON { (response) in
                    
                    if let statusCode = response.response?.statusCode{
                        
                        let data = response.result.value
                        
                        switch (statusCode){
                        case 400:
                            failed(data as? NSDictionary)
                        default:
                            break
                        }
                        
                        //                            if statusCode == 200{
                        //
                        //                                if let json = response.result.value{
                        //                                    completion(json as? NSDictionary)
                        ////                                    let abc = json as! NSDictionary
                        ////                                    let z = abc.object(forKey: "report_array") as! NSArray
                        ////                                    for index in 0...z.count-1{
                        ////                                        let f = z[index] as! [String:AnyObject]
                        ////                                        let s = f["user_id"]
                        ////                                        print(s)
                        ////                                    }
                        //                                    
                        //                                }
                        //                            }
                    }
                    
//                    switch response.result{
//                    case .success:
//                        if let statusCode = response.response?.statusCode{
//                            print(statusCode)
//                            switch (statusCode){
//                            case 400:
//                                if let jsonFailed = response.result.value{
//                                    failed(jsonFailed as? NSDictionary)
//                                }
//                                print("Client error")
//                            default:
//                                break
//                            }
//
////                            if statusCode == 200{
////                                
////                                if let json = response.result.value{
////                                    completion(json as? NSDictionary)
//////                                    let abc = json as! NSDictionary
//////                                    let z = abc.object(forKey: "report_array") as! NSArray
//////                                    for index in 0...z.count-1{
//////                                        let f = z[index] as! [String:AnyObject]
//////                                        let s = f["user_id"]
//////                                        print(s)
//////                                    }
////                                    
////                                }
////                            }
//                        }
//                        print("Call me ss")
//                    case .failure(_):
//                        print("Call mef")
//                        if let statusCode = response.response?.statusCode{
////                            failed(ELog("Status code: \(statusCode)"))
//                            print(statusCode)
//                            switch (statusCode){
//                            case 404:
//                                if let jsonFailed = response.result.value{
//                                    failed(jsonFailed as? NSDictionary)
//                                }
//                                print("Client error")
//                            default:
//                                break
//                            }
//                        }
//                    }
                }
            }else{
//                failed(Alert(title: STRING_CHECK_INPUT_DATA))
            }
        }
    }
}
