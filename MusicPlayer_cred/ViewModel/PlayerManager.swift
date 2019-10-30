//
//  PlayerManager.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlayerManager{
    var player: AVPlayer?
    var currentSong : URL?
    
    static let sharedInstance = PlayerManager()
    
    private init() {}
    
    func playSong(url:URL,view:UIView,controller:UIViewController) {
           if let play = player{
               let playerItem: AVPlayerItem = AVPlayerItem(url: url)
               player = AVPlayer(playerItem: playerItem)
               let playerLayer = AVPlayerLayer(player: player!)
               playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
               view.layer.addSublayer(playerLayer)
               play.play()
           }else{
               print("player allocated")
               let playerItem: AVPlayerItem = AVPlayerItem(url: url)
               player = AVPlayer(playerItem: playerItem)
               player!.play()
        }
       }
    
       func stopPlayer() {
           if let play = player {
               play.pause()
               player = nil
               print("player deallocated")
           } else {
               print("player was already deallocated")
           }
       }
       
       func pausePlayer(){
           if let play = player{
               play.pause()
               print("Player Paused")
           }
       }
       
       func resumePlayer(){
           if let play = player{
               play.play()
           }
       }
}
