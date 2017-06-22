//
//  TRCConfigConstant.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//
import UIKit


//localized string
func Localizable(value: String) -> String {
    return NSLocalizedString(value, comment: "")
}

func LocalizableWithComment(value: String, withComment: String) -> String{
    return NSLocalizedString(value, comment: withComment)
}


//log
#if DEBUG
    func ELog(_ text: String,  fileName: String = #file, function: String =  #function, line: Int = #line) {
        print("[\((fileName as NSString).lastPathComponent)] [\(function)] [Line: \(line)] -:- \(text)")
    }
#else
    func ELog(_ text: String) {
        print("")
    }
#endif
