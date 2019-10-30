//
//  PlaylistViewModel.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation


protocol PlaylistViewModelDelegate : class{
    func downloadComplete(playlist:[Song?])
    func downloadFailed()
}

class PlaylistViewModel{
    
    weak var playlistVMDelegate : PlaylistViewModelDelegate?
    
    func getPlaylist(){
        ServerManager.sharedInstance.getPlaylist { (Songs, serverError) in
            if let error = serverError{
                print(error.details.message)
                self.playlistVMDelegate?.downloadFailed()
            }else{
                self.playlistVMDelegate?.downloadComplete(playlist: Songs)
            }
        }
    }
}
