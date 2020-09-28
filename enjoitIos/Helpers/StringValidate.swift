//
//  StringValidate.swift
//  enjoitIos
//
//  Created by developapp on 25/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation

public extension String {
    
    /// SwifterSwift: Check if string contains one or more letters.
    ///
    ///        "123abc".hasLetters -> true
    ///        "123".hasLetters -> false
    ///
    var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }

    /// SwifterSwift: Check if string contains one or more numbers.
    ///
    ///        "abcd".hasNumbers -> false
    ///        "123abc".hasNumbers -> true
    ///
    var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }

    /// SwifterSwift: Check if string contains only letters.
    ///
    ///        "abc".isAlphabetic -> true
    ///        "123abc".isAlphabetic -> false
    ///
    var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    /// SwifterSwift: Check if string contains only letters.
    ///
    ///        "abc".isAlphabetic -> true
    ///        "123abc".isAlphabetic -> false
    ///
    var isNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasNumbers && !hasLetters
    }

    /// SwifterSwift: Check if string contains at least one letter and one number.
    ///
    ///        // useful for passwords
    ///        "123abc".isAlphaNumeric -> true
    ///        "abc".isAlphaNumeric -> false
    ///
    var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }


}
