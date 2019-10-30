//
//  MultipleFieldFormCell.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

class MultipleFieldFormCell: UITableViewCell {

    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!

    @IBOutlet weak var tf1: UITextField!
    
    @IBOutlet weak var tf2: UITextField!
    
    
    var formData:[String] = []{
        didSet{
            if formData.count > 0{
                let data = formData[0].components(separatedBy: "|")
                
                if data.count>0{
                    lbl1.text = data[0]
                    tf1.addLine(width: 0.3)
                }
                
                if data.count>1{
                    lbl2.text = data[1]
                    tf2.addLine(width: 0.3)
                }
            }
        }
    }
}
