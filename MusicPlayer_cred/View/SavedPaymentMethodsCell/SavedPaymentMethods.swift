//
//  SavedPaymentMethods.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

class SavedPaymentMethods: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var expiry: UILabel!
    @IBOutlet weak var CardView: UIView!
    
    var cardData : SavedCards?{
        didSet{
            
            self.setupUI()
            if let image = cardData?.type{
                let (color1,color2) = image.gradientColor
                self.setGradient(color1: color1, color2: color2)
                cardName.text = cardData?.Name
                let result = modifyCreditCardString(creditCardString:(cardData?.cardNumber!)!)
                expiry.text = cardData?.expiryDate
                cardNumber.text = result
                cardImage.image = image.image
            }
           
            
        }
    }
    
    func setupUI(){
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if(arrOfCharacters.count > 0) {
            for i in 0...arrOfCharacters.count-1 {
               
                if i >= arrOfCharacters.count-4 {
                    modifiedCreditCardString.append(arrOfCharacters[i])
                }else{
                    modifiedCreditCardString.append("X")
                }
                
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }
    
    private func setGradient(color1: UIColor,color2: UIColor)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.frame = self.bounds
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer
        {
            topLayer.removeFromSuperlayer()
        }
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}

