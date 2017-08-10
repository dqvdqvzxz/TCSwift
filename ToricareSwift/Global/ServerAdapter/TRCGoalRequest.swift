//
//  TRCGoalRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/9/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCGoalRequest: TRCBaseAPIController {
    func goalInfo(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_GOAL)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func goalStepsChange(_ steps: String,completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[GOAL_STEP] = steps
        parameters[GOAL_WEIGHT] = _obj.objectGoal.weight
        
        self.callAPI(parameters, atPath: "\(URL_GOAL)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
