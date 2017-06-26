//
//  TRCCheckNetwork.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity: NSObject {
    class func isConnectToNetwork() -> Bool{
        return NetworkReachabilityManager()!.isReachable
    }
}
