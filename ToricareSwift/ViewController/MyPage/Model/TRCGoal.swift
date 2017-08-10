//
//  TRCGoal.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/9/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

struct TRCGoal {
    var id = ""
    var weight = ""
    var steps = ""
}

extension TRCGoal: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.id = try decoder.value(forKey: GOAL_ID)
        self.weight = try decoder.value(forKey: GOAL_WEIGHT)
        self.steps = try decoder.value(forKey: GOAL_STEPS)
    }
}
