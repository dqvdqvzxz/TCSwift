//
//  TRCAccountInfo.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/9/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

struct TRCAccountInfo {
    var email = ""
    var firstName = ""
    var lastName = ""
    var firstNameKata = ""
    var lastNameKata = ""
    var birthDay = ""
    var sex = ""
    var imagePath: TRCImage
    var shopId = ""
}

extension TRCAccountInfo: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.email = try decoder.value(forKey: REGISTER_PARAM_EMAIL)
        self.firstName = try decoder.value(forKey: REGISTER_PARAM_FIRST_NAME)
        self.lastName = try decoder.value(forKey: REGISTER_PARAM_LAST_NAME)
        self.firstNameKata = try decoder.value(forKey: REGISTER_PARAM_FIRST_NAME_KATA)
        self.lastNameKata = try decoder.value(forKey: REGISTER_PARAM_LAST_NAME_KATA)
        self.birthDay = try decoder.value(forKey: REGISTER_PARAM_BIRTHDAY)
        self.sex = try decoder.value(forKey: REGISTER_PARAM_GENDER_TYPE)

        if (try decoder.isNull(forKey: REGISTER_PARAM_IMAGE_PATH)) {
            self.imagePath = TRCImage(origin: "")
        } else {
            self.imagePath = try parseDict(decoder.value(forKey: REGISTER_PARAM_IMAGE_PATH))
        }
        self.shopId = try decoder.value(forKey: REGISTER_PARAM_SHOP_ID)
    }
}
