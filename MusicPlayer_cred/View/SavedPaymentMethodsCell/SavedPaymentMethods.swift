//
//  SavedPaymentMethods.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 29/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

class SavedPaymentMethods: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    
    var cardData : SavedCards?{
        didSet{
            cardName.text = cardData?.Name
            let intLetters = cardData?.cardNumber!.prefix(6)
            let endLetters = cardData?.cardNumber!.suffix(3)
            let stars = String(repeating: "X", count: (cardData?.cardNumber!.count)! - 5)
            let result = "\(intLetters!)\(stars)\(endLetters!)"
            
            cardNumber.text = result
            let image = cardData?.type!
            cardImage.image = image?.image
        }
    }
}
