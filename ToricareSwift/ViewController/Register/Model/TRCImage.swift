//
//  TRCImage.swift
//  ToricareSwift
//
//  Created by tuan on 8/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation

struct TRCImage
{
    var origin = ""
//    var thumb1: String
}

extension TRCImage: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.origin = try decoder.value(forKey: ORIGIN)
//        self.thumb1 = try decoder.value(forKey: THUMB1)
    }
}
