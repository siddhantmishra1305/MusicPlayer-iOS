//
//  PlaylistCellTableViewCell.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit

class PlaylistCell: UITableViewCell {

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var artists: UILabel!
    @IBOutlet weak var currentlyPlaying: UIImageView!
    
    var cellData : Song?{
        didSet{
            if let song = cellData?.song{
                songName.text = song
            }
            
            if let artist = cellData?.artists{
                artists.text = artist
            }
            setNeedsUpdateConstraints()
            updateConstraintsIfNeeded()
            
            if let selected = cellData?.isSelected{
                if selected{
                    songName.textColor = #colorLiteral(red: 0.6862745098, green: 0.6156862745, blue: 0.4039215686, alpha: 1)
                    artists.textColor = #colorLiteral(red: 0.6862745098, green: 0.6156862745, blue: 0.4039215686, alpha: 1)
                    index.textColor = #colorLiteral(red: 0.6862745098, green: 0.6156862745, blue: 0.4039215686, alpha: 1)
                    self.currentlyPlaying.isHidden = false
                    self.currentlyPlaying.image = UIImage.gifImageWithName("SongPlaying")
                }else{
                    songName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    artists.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    index.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    self.currentlyPlaying.isHidden = true
                }
            }
        }
    }
        
    var serialNum : Int?{
        didSet{
            index.text = "\(serialNum!)"
        }
    }
    
}
