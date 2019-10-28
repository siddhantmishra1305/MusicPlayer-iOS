//
//  SingleFieldFormCell.swift
//  BeerCraft
//
//  Created by Siddhant Mishra on 01/08/19.
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
