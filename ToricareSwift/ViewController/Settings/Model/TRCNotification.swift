//
//  TRCNotification.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/17/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

struct TRCNotification{
    var isPush = ""
    var isReceivedOperator = ""
    var isReceivedShop = ""
    var isReceivedWeight = ""
    var isReceivedBreakfast = ""
    var isReceivedLunch = ""
    var isReceivedDinner = ""
    var isReceivedSnack = ""
    var timeWeight = ""
    var timeBreakfast = ""
    var timeLunch = ""
    var timeDinner = ""
    var timeSnack = ""
}

extension TRCNotification: JSONDecodable{
    init(_ decoder: JSONDecoder) throws {
        self.isPush = try decoder.value(forKey: NOTIF_PARAM_PUSHED)
        self.isReceivedOperator = try decoder.value(forKey: NOTIF_PARAM_OPERATOR)
        self.isReceivedShop = try decoder.value(forKey: NOTIF_PARAM_SHOP)
        self.isReceivedWeight = try decoder.value(forKey: NOTIF_PARAM_WEIGHT)
        self.isReceivedBreakfast = try decoder.value(forKey: NOTIF_PARAM_BREAKFAST)
        self.isReceivedLunch = try decoder.value(forKey: NOTIF_PARAM_LUNCH)
        self.isReceivedDinner = try decoder.value(forKey: NOTIF_PARAM_DINNER)
        self.isReceivedSnack = try decoder.value(forKey: NOTIF_PARAM_SNACK)
        self.timeWeight = try decoder.value(forKey: NOTIF_PARAM_TIME_WEIGHT)
        self.timeBreakfast = try decoder.value(forKey: NOTIF_PARAM_TIME_BREAKFAST)
        self.timeLunch = try decoder.value(forKey: NOTIF_PARAM_TIME_LUNCH)
        self.timeDinner = try decoder.value(forKey: NOTIF_PARAM_TIME_DINNER)
        self.timeSnack = try decoder.value(forKey: NOTIF_PARAM_TIME_SNACK)
    }
}
