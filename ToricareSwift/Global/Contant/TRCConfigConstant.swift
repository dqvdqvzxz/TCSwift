//
//  TRCConfigConstant.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//
import UIKit

//MARK: Singleton
let _obj = Singleton.shared

//MARK: Localize String
func Localizable(value: String) -> String {
    return NSLocalizedString(value, comment: "")
}

func LocalizableWithComment(value: String, withComment: String) -> String{
    return NSLocalizedString(value, comment: withComment)
}


//MARK: Debug log level
//DEBUG_LEVEL_1 : show all log, include variable, value and error
//DEBUG_LEVEL_2 : only show error log
//other : do not show log
#if DEBUG_LEVEL_1
    func DLog(_ text: Any,  fileName: String = #file, function: String =  #function, line: Int = #line) {
        print("[\((fileName as NSString).lastPathComponent)] [\(function)] [Line: \(line)] -:- \(text)")
    }
    func ELog(_ text: Any,  fileName: String = #file, function: String =  #function, line: Int = #line) {
        print("[\((fileName as NSString).lastPathComponent)] [\(function)] [Line: \(line)] -:- \(text)")
    }
#elseif DEBUG_LEVEL_2
    func DLog() {
        print("")
    }
    func ELog(_ text: Any,  fileName: String = #file, function: String =  #function, line: Int = #line) {
        print("[\((fileName as NSString).lastPathComponent)] [\(function)] [Line: \(line)] -:- \(text)")
    }
#else
    func DLog(_ text: Any) {
        print("")
    }
    func ELog(_ text: Any) {
        print("")
    }
#endif

//MARK: Screen size
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

//MARK: Color
let MAIN_COLOR = "0caa7d"
let MAIN_COLOR_2 = "2196f3"
let MAIN_COLOR_3 = "8e24aa"
let MAIN_COLOR_4 = "f44336"

//button
let BUTTON_TITLE_COLOR = "fafafa"
let BUTTON_FONT_SIZE: CGFloat? = 16
let BUTTON_RADIUS: CGFloat? = 5
let BUTTON_BORDER_WIDTH: CGFloat? = 1
let BUTTON_BORDER_COLOR = "0caa7d"

//label
let LABEL_FONT_SIZE: CGFloat? = 16
let LABEL_FONT_COLOR = "414141"
let LABEL_FONT_GREY_COLOR = "a8a8a8"
let LABEL_FONT_CELL_TITLE_SIZE: CGFloat = 15
let LABEL_FONT_CELL_SUBTITLE_SIZE: CGFloat = 13
let LABEL_FORGOT_PASSWORD_FONT_COLOR = "29b6f6"

//text field 
let TEXTFIELD_FONT_SIZE: CGFloat? = 16
let TEXTFIELD_FONT_COLOR = "414141"
let TEXTFIELD_BORDER_WIDTH: CGFloat? = 0.5
let TEXTFIELD_BORDER_COLOR = "414141"
let TEXTFIELD_RADIUS: CGFloat? = 5
let TEXTFIELD_BACKGROUND = "efeff4"

//facebook
let BUTTON_REGISTER_FB = "3F5A99"
let BUTTON_REGISTER_FB_BORDER = "3F5A99"


//view
let BACKGROUND_COLOR = "8e8e93"
let COLLECTION_CELL_COLOR = "ceced2"
let GREY_BACKGROUND_COLOR = "F0F0F2"
