//
//  ViewController.swift
//  MusicPlayer_cred
//
//  Created by Siddhant Mishra on 30/10/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import AVFoundation
import FSPagerView

class PlaylistViewController: UIViewController {
 
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var backgroundCover: UIImageView!
    @IBOutlet weak var coverImages: FSPagerView!
    @IBOutlet weak var playerControls: UIView!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var playlistTableView: UITableView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var songStatusStartLBL: UILabel!
    @IBOutlet weak var songStatusRemaingLBL: UILabel!
    var currentIndex = 0
    let playlistViewModel = PlaylistViewModel()
    var songs : [Song?]?
    var observer:Any?
    
    // MARK: View setup functions
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.register(UINib(nibName: "PlaylistCell", bundle: nil), forCellReuseIdentifier: "PlaylistCell")
        self.setupPagerView()
        self.setupNavigationBar()
        playlistViewModel.playlistVMDelegate = self
        playlistTableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        songs?.removeAll()
        playlistViewModel.getPlaylist()
        self.showSpinner(title: "Please Wait")
        self.progressBar.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
       {
           let seconds : Int64 = Int64(playbackSlider.value)
           let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
           
            if let player = PlayerManager.sharedInstance.player{
                player.seek(to: targetTime)
                if player.rate == 0
                {
                    player.play()
                }
                playBtn.setBackgroundImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            }
            
       }

    
    func setupPagerView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundCover.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundCover.addSubview(blurEffectView)
        coverImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerCell")
        coverImages.transformer = FSPagerViewTransformer(type: .depth)
    }
    
    func refreshSlider(sliderValue:Float){
        self.progressBar.minimumValue = 0.0
        self.songStatusStartLBL.isHidden = false
        self.songStatusRemaingLBL.isHidden = false
        
        let val = Float(sliderValue)
            self.progressBar.setValue(val, animated: false)
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let time = PlayerManager.sharedInstance.player?.currentItem?.asset.duration{
                    let value = CMTimeGetSeconds(time)
                    DispatchQueue.main.async {
                        self.progressBar.maximumValue = Float(value)
                    }
                }
            }
            let currentVal = Int(self.progressBar.value)
            let remainingVal = Int(self.progressBar.maximumValue - self.progressBar.value)
           
            self.songStatusStartLBL.text = self.getFormatedTime(FromTime: currentVal)
            self.songStatusRemaingLBL.text = self.getFormatedTime(FromTime: remainingVal)
    }
    
    // MARK: Button Actions
    @IBAction func backBtnAction(_ sender: Any) {
        self.playPreviousSong()
    }
        
    
    @IBAction func playBtnAction(_ sender: Any) {
        self.playPauseSong()
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        self.playNextSong()
    }
    
// MARK: Player Controller Functions
  func playNextSong(){
    self.validateAndPlay(index: currentIndex + 1)
}
    
    func playPreviousSong(){
        self.validateAndPlay(index:currentIndex - 1)
    }
    
    func validateAndPlay(index:Int){
        if ReachabilityTest.isConnectedToNetwork(){
            if let songDetails = songs{
                if songDetails.count > 0{
                    if songDetails.indices.contains(index) {
                        self.playSong(index: index)
                    }
                }
            }
        }else {
            self.showAlert(Title: "Alert", Message: "No Internet Connection")
        }
    }
    
    func playPauseSong(){
        if let play = PlayerManager.sharedInstance.player{
            if play.timeControlStatus == .playing {
                play.pause()
                if currentIndex > songs!.count{
                    songs![currentIndex]?.isSelected = false
                }
                playBtn.setBackgroundImage(#imageLiteral(resourceName: "Play"), for: .normal)
            } else {
                play.play()
                if currentIndex > songs!.count{
                    songs![currentIndex]?.isSelected = true
                }
                playBtn.setBackgroundImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            }
            playlistTableView.reloadData()
        }else {
             if ReachabilityTest.isConnectedToNetwork(){
                validateAndPlay(index: currentIndex)
                if songs!.count>0{
                    self.updateSongsStatus(index: 0)
                }
            } else{
                self.showAlert(Title: "Alert", Message: "No Internet Connection")
            }
        }
    }
    
    func playSong(index:Int)  {
        if ReachabilityTest.isConnectedToNetwork(){
            coverImages.scrollToItem(at: index, animated: true)
            if let songDetails = songs{
                if let songData = songDetails[index]{
                    if let songurl = songData.url{
                        if let url = URL(string: songurl){
                            
                            if self.observer != nil{
                                //removing time observer
                                PlayerManager.sharedInstance.player!.removeTimeObserver(observer as Any)
                                NotificationCenter.default.removeObserver(self)
                                observer = nil
                            }
                            PlayerManager.sharedInstance.stopPlayer()
                            PlayerManager.sharedInstance.playSong(url: url, view: self.view, controller: self)
                            NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: PlayerManager.sharedInstance.player!.currentItem)
                            self.showSpinner(title: "Buffering")
                            self.preriodicTimeObsever()
                            currentIndex = index
                            self.updateSongsStatus(index: index)
                            self.playBtn.setBackgroundImage(#imageLiteral(resourceName: "Pause"), for: .normal)
                        }
                    }
                }
            }
            playlistTableView.reloadData()
        }else{
            self.showAlert(Title: "Alert", Message: "No Inernet Connection")
        }
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        self.playNextSong()
    }
    
}

// MARK: Pager View Delegate Functions

extension PlaylistViewController: FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if let count = songs?.count{
            return count
        } else {
            return 0
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerCell", at: index)
        
        if let url = songs![index]?.cover_image{
            cell.imageView?.imageFromServerURL(url, placeHolder: nil)
        }
        
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
        
        cell.layer.cornerRadius = 10.0
        cell.clipsToBounds = true
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        if let url = songs![index]?.cover_image{
            backgroundCover.imageFromServerURL(url, placeHolder: nil)
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        validateAndPlay(index: index)
    }

}

// MARK: TableView data source functions
extension PlaylistViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = songs?.count{
                   return count
               } else {
                   return 0
               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as! PlaylistCell
        if let cellData = songs![indexPath.row]{
           cell.cellData = cellData
           cell.serialNum = indexPath.row + 1
        }
        return cell
    }
}

// MARK: TableView Delegate Functions
extension PlaylistViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        validateAndPlay(index: indexPath.row)
    }
}

// MARK: PlaylistViewModel Delegate Functions
extension PlaylistViewController: PlaylistViewModelDelegate{
    func downloadFailed() {
        self.removeSpinner()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ErrorViewController") as! ErrorViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func downloadComplete(playlist: [Song?]) {
        songs = playlist
        self.removeSpinner()
        playlistTableView.reloadData()
        coverImages.reloadData()
        if songs!.count > 0 {
        if let songData = songs![0]{
            if let songurl = songData.url{
                if let url = URL(string: songurl){
                    PlayerManager.sharedInstance.currentSong = url
                    currentIndex = 0
                    }
                }
            }
        }
    }
    
    func updateSongsStatus(index:Int){
        if let songDetails = songs{
            for item in 0..<songDetails.count{
                if item == index{
                    songs![item]?.isSelected = true
                } else{
                    songs![item]?.isSelected = false
                }
            }
        }
    }
    
}

extension PlaylistViewController{
    func preriodicTimeObsever(){

        if self.observer != nil{
            //removing time observer
            PlayerManager.sharedInstance.player!.removeTimeObserver(observer as Any)
            observer = nil
        }

        let intervel : CMTime = CMTimeMake(value: 1, timescale: 10)
        observer = PlayerManager.sharedInstance.player!.addPeriodicTimeObserver(forInterval: intervel, queue: DispatchQueue.main) { [weak self] time in

            guard let `self` = self else { return }

            let sliderValue : Float64 = CMTimeGetSeconds(time)
            guard self.progressBar.isTracking == false else { return }
            self.refreshSlider(sliderValue: Float(sliderValue))
            let playbackLikelyToKeepUp = PlayerManager.sharedInstance.player!.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{

            }else{
                self.removeSpinner()
            }
        }
    }
    func getFormatedTime(FromTime timeDuration:Int) -> String {

      let minutes = Int(timeDuration) / 60 % 60
      let seconds = Int(timeDuration) % 60
      let strDuration = String(format:"%02d:%02d", minutes, seconds)
      return strDuration
    }
}

extension PlaylistViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu()
        })
    }
    
    func makeContextMenu() -> UIMenu {

        // Create a UIAction for sharing
        let share = UIAction(title: "Buy now", image: UIImage(systemName: "square.and.arrow.up")) { action in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }

        // Create and return a UIMenu with the share action
        return UIMenu(title: "Main Menu", children: [share])
    }
    
}
