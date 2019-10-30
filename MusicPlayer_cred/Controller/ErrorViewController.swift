//
//  ErrorViewController.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit


class ErrorViewController: UIViewController {

    @IBOutlet weak var tryAgainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tryAgainBtn.layer.cornerRadius = 8.0
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    @IBAction func tryAgainAction(_ sender: Any) {
        if ReachabilityTest.isConnectedToNetwork() {
           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlaylistViewController") as! PlaylistViewController
           self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        else{
        }
        
    }
}

