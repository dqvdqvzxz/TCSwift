//
//  TRCSummary.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/10/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

struct TRCSummary {
    var memberID = ""
    var step = ""
    var consumptCalo = ""
    var intakeCalo = ""
    var stepPercent = ""
}

extension TRCSummary: JSONDecodable{
    init(_ decoder: JSONDecoder) throws {
        self.memberID = try decoder.value(forKey: SUMMARY_MEMBER_ID)
        self.step = try decoder.value(forKey: SUMMARY_STEP)
        self.consumptCalo = try decoder.value(forKey: SUMMARY_CONSUMPT_CALO)
        self.intakeCalo = try decoder.value(forKey: SUMMARY_INTAKE_CALO)
        self.stepPercent = try decoder.value(forKey: SUMMARY_STEP_PERCENT)
    }
}

