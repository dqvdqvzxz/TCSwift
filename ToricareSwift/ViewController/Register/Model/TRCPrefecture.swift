//
//  TRCPrefecture.swift
//  ToricareSwift
//
//  Created by tuan on 8/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation

struct TRCPrefecture
{
    var name: String
    var prefectureId: String
    
    init(name aName: String, prefecture aPrefecture: String) {
        name = aName
        prefectureId = aPrefecture
    }
}

extension TRCPrefecture: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws {
        self.name = try decoder.value(forKey: NAME)
        self.prefectureId = try decoder.value(forKey: PREFECTURE_ID)
    }
}
