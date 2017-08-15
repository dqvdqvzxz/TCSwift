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
    var calo = ""
    var unread = ""
}

extension TRCSummary: JSONDecodable{
    init(_ decoder: JSONDecoder) throws {
        self.memberID = try decoder.value(forKey: SUMMARY_MEMBER_ID)
        self.step = try decoder.value(forKey: SUMMARY_STEP)
        self.calo = try decoder.value(forKey: SUMMARY_CALO)
        self.unread = try decoder.value(forKey: SUMMARY_UNREAD)
    }
}

