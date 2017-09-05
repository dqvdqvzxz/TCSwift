//
//  TRCPharmacist.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 9/1/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

struct TRCPharmacist {
    var id = ""
    var name = ""
    var tel = ""
    var email = ""
    var note = ""
}

extension TRCPharmacist: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.id = try decoder.value(forKey: PHARMACIST_ID)
        self.name = try decoder.value(forKey: PHARMACIST_NAME)
        self.tel = try decoder.value(forKey: PHARMACIST_TEL)
        self.email = try decoder.value(forKey: PHARMACIST_EMAIL)
        self.note = try decoder.value(forKey: PHARMACIST_NOTE)
    }
}
