//
//  SavedCards.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation

typealias Card = [SavedCards]

struct SavedCards {
       public var Name: String?
       public var CVV: Int?
       public var cardNumber: String?
       public var expiryDate:String?
       public var type: CardTypes?
}
