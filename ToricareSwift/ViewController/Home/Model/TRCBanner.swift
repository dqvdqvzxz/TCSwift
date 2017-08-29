//
//  TRCBanner.swift
//  ToricareSwift
//
//  Created by tuan on 8/29/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation

struct TRCBanner {
    var bannerId = ""
    var imagePath: TRCImage
    var url = ""
}

extension TRCBanner: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.bannerId = try decoder.value(forKey: ID)
        if (try decoder.isNull(forKey: REGISTER_PARAM_IMAGE_PATH)) {
            self.imagePath = TRCImage(origin: "")
        } else {
            self.imagePath = try parseDict(decoder.value(forKey: REGISTER_PARAM_IMAGE_PATH))
        }
        self.url = try decoder.value(forKey: URL_KEY)
    }
}
