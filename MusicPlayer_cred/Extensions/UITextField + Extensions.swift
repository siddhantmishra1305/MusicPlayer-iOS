//
//  UITextField + Extensions.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{

func validateCreditCardFormat()-> (type: CardTypes, valid: Bool) {
        // Get only numbers from the input string
    let input = self.text!
    let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "")
//    ("[^0-9]", withString: " ")

    var type: CardTypes = .Unknown
    var formatted = ""
    var valid = false

    // detect card type
    for card in CardTypes.allCards {
        if (matchesRegex(regex: card.regex, text: numberOnly)) {
            type = card
            valid = true
            break
        }
    }

    // format
    var formatted4 = ""
    for character in numberOnly {
        if formatted4.count == 4 {
            formatted += formatted4 + " "
            formatted4 = ""
        }
        formatted4.append(character)
    }

    formatted += formatted4 // the rest

    // return the tuple
    return (type, valid)
}

func matchesRegex(regex: String!, text: String!) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        let nsString = text as NSString
        let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
        return (match != nil)
    } catch {
        return false
    }
}


}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
