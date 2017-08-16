//
//  String.swift
//  ToricareSwift
//
//  Created by tuan on 8/3/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation

extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    //Validate Alpha Numeric
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isLengthBelow7: Bool {
        return self.characters.count <= 7
    }
    
    var isLengthOver33: Bool {
        return self.characters.count >= 32
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                return true
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
//    var containsHankakuCharacters: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: "[^A-Za-z0-9]+", options: .caseInsensitive)
//            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
//                return true
//            }else{
//                return false
//            }
//        } catch {
//            return false
//        }
//    }

}
