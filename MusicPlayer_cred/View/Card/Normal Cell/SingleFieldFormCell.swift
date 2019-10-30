//
//  SingleFieldFormCell.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

class SingleFieldFormCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var nameTf: UITextField!
    
    
    
    var formData:[String] = []{
        didSet{
            if formData.count>0{
                lblName.text = formData[0]
                nameTf.addLine(width: 0.3)
            }
        }
    }
}
