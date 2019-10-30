//
//  CardTypes.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
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
    
    var gradientColor : (UIColor,UIColor){
        switch self {
        case .Amex:
            let color1 = #colorLiteral(red: 0.1725490196, green: 0.2431372549, blue: 0.3137254902, alpha: 1)
            let color2 = #colorLiteral(red: 0.2980392157, green: 0.631372549, blue: 0.6862745098, alpha: 1)
            return (color1,color2)
            
        case .Visa:
            let color1 = #colorLiteral(red: 0.1176470588, green: 0.2352941176, blue: 0.4470588235, alpha: 1)
            let color2 = #colorLiteral(red: 0.1647058824, green: 0.3215686275, blue: 0.5960784314, alpha: 1)
            return (color1,color2)
        
        case .MasterCard:
            let color1 = #colorLiteral(red: 0.9568627451, green: 0.4196078431, blue: 0.2705882353, alpha: 1)
            let color2 = #colorLiteral(red: 0.9333333333, green: 0.6588235294, blue: 0.2862745098, alpha: 1)
             return (color1,color2)
        
        case .Diners:
            let color1 = #colorLiteral(red: 0.7411764706, green: 0.7647058824, blue: 0.7803921569, alpha: 1)
            let color2 = #colorLiteral(red: 0.1725490196, green: 0.2431372549, blue: 0.3137254902, alpha: 1)
             return (color1,color2)
        
        case .Discover:
            let color1 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            let color2 = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
             return (color1,color2)
        
        case .Maestro:
            let color1 = #colorLiteral(red: 0, green: 0.3607843137, blue: 0.5921568627, alpha: 1)
            let color2 = #colorLiteral(red: 0.2117647059, green: 0.2156862745, blue: 0.5843137255, alpha: 1)
             return (color1,color2)
        
        case .Unknown:
            let color1 = #colorLiteral(red: 1, green: 0.3725490196, blue: 0.4274509804, alpha: 1)
            let color2 = #colorLiteral(red: 1, green: 0.7647058824, blue: 0.4431372549, alpha: 1)
            return (color1,color2)

        }
    }
}
