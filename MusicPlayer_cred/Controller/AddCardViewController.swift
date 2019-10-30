//
//  AddCardViewController.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

protocol cardDelegate : class{
    func cardAdded(card:SavedCards)
}

class AddCardViewController: UIViewController {

    var formArr = [[String]]()
        
        @IBOutlet weak var addCard: UIButton!
    
        weak var card_Delegate : cardDelegate?
    
        @IBOutlet weak var addCardForm: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()

           addCardForm.register(UINib(nibName: "MultipleFieldFormCell", bundle: nil), forCellReuseIdentifier: "MultipleFieldFormCell")
            
            addCardForm.register(UINib(nibName: "SingleFieldFormCell", bundle: nil), forCellReuseIdentifier: "SingleFieldFormCell")
            addCard.layer.cornerRadius = 10.0
            addCard.clipsToBounds = true
            addCardForm.estimatedRowHeight = 120
            addCardForm.rowHeight = UITableView.automaticDimension
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            var personalDetailArr = [String]()
            var deliveryArr = [String]()
            
            personalDetailArr.append("Name on card")
            personalDetailArr.append("Card number")
            personalDetailArr.append("Expiry Date(MM/YY)|CVV")
            
            deliveryArr.append("House No|Apartment")
            deliveryArr.append("Street details")
            deliveryArr.append("City|Area")
            deliveryArr.append("Pincode")
            
            formArr.append(personalDetailArr)
            formArr.append(deliveryArr)
        }
    
    @IBAction func saveCardAction(_ sender: Any) {
        var cardDetail = SavedCards()
      
        let indexpathForName = IndexPath(row: 0, section: 0)
        let indexpathForCardNumber = IndexPath(row: 1, section: 0)
        let indexpathForExpiry =  IndexPath(row: 2, section: 0)
        
        let nameCell = addCardForm.cellForRow(at: indexpathForName) as! SingleFieldFormCell
        let cardNumberCell = addCardForm.cellForRow(at: indexpathForCardNumber) as! SingleFieldFormCell
        let expiryCell = addCardForm.cellForRow(at: indexpathForExpiry) as! MultipleFieldFormCell
        
        guard let name = nameCell.nameTf.text else{
            self.showAlert(Title: "Alert", Message: "Please enter a name")
            return
        }
        cardDetail.Name = name
        
        guard let cardNumber = cardNumberCell.nameTf.text else{
            self.showAlert(Title: "Alert", Message: "Please enter card number")
            return
        }
        
        let (type,status) = cardNumberCell.nameTf.validateCreditCardFormat()
        
        if status && type != nil{
            cardDetail.cardNumber = cardNumber
            cardDetail.type = type
        }else{
            self.showAlert(Title: "Alert", Message: "Card not supported")
            return
        }
        
        guard let expiryDate = expiryCell.tf1.text else{
            self.showAlert(Title: "Alert", Message: "Invalid expiry date")
            return
        }
        cardDetail.expiryDate = expiryDate
        
        guard let CVV = expiryCell.tf2.text else {
             self.showAlert(Title: "Alert", Message: "Please enter CVV")
             return
        }
            if CVV.isNumeric{
                cardDetail.CVV = Int(CVV)
            } else{
                self.showAlert(Title: "Alert", Message: "Invalid CVV")
                return
            }
        
        self.navigationController?.popViewController(animated: true)
        
        self.card_Delegate?.cardAdded(card: cardDetail)
        
    }
}


    extension AddCardViewController : UITableViewDelegate, UITableViewDataSource{
        
         func numberOfSections(in tableView: UITableView) -> Int {
            return formArr.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return formArr[section].count
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 20
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            let label = UILabel()
            label.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
            label.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            label.backgroundColor = UIColor.white
            
            if section == 0 {
                label.text = "Card Details"
                return label
            } else{
                label.text = "Address Details"
                return label
            }
            
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 65.0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let arr = formArr[indexPath.section]
            
            if arr[indexPath.row].contains("|"){
                let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleFieldFormCell", for: indexPath) as! MultipleFieldFormCell
                
                cell.formData = [arr[indexPath.row]]
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SingleFieldFormCell", for: indexPath) as! SingleFieldFormCell
                
                cell.formData = [arr[indexPath.row]]
                return cell
            }
        }
    }

