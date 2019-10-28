//
//  PaymentViewController.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 29/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var savedCardsList: UITableView!
    let addCardVC = AddCardViewController()
    @IBOutlet weak var addNewCard: UIButton!
    
    var cards = Card()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedCardsList.register(UINib(nibName: "SavedPaymentMethods", bundle: nil), forCellReuseIdentifier: "SavedPaymentMethods")
        addCardVC.card_Delegate = self
        addNewCard.layer.cornerRadius = 10.0
        addNewCard.clipsToBounds = true
    }
    
    @IBAction func addNewCardAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCardViewController") as! AddCardViewController
        nextViewController.card_Delegate = self
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

extension PaymentViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "SavedPaymentMethods", for: indexPath) as! SavedPaymentMethods
         cell.cardData = cards[indexPath.row]
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
}

extension PaymentViewController : cardDelegate{
    func cardAdded(card: SavedCards) {
        cards.append(card)
        savedCardsList.reloadData()
    }

}
