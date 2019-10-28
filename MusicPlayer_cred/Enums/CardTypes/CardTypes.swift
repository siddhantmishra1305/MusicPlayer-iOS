//
//  CardTypes.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 29/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import UIKit

enum CardTypes{

    case Visa
    case Maestro
    case Diners
    case Amex
    case MasterCard
    case Discover
    case Unknown
    
    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, Maestro]
    var image: UIImage?{
        
        switch self {
        
            case .Visa:
                return #imageLiteral(resourceName: "Visa")
                
            case .Maestro:
                return #imageLiteral(resourceName: "Maestro")
            
            case .Amex:
                return #imageLiteral(resourceName: "Amex")
            
            case .MasterCard:
                return #imageLiteral(resourceName: "MasterCard")
         
            case .Diners:
                return #imageLiteral(resourceName: "Diners")
        
            case .Discover:
                return #imageLiteral(resourceName: "Discover")
            
            case .Unknown:
                return nil
        }
    }
    
    var regex : String {
    switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
            return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .Diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .Maestro:
            return "^(5018|5020|5038|6304|6759|6761|6763)[0-9]{8,15}$"
        
        default:
        return ""
        
        }
    }
}
