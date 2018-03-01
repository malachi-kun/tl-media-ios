//
//  HomeViewController.swift
//  tl-media-ios - chabi-labo
//
//  Created by Malachi Hul on 2017/12/14.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
// The initial view controller that holds the HomeRootViewController and BottonAudioBar
//

import UIKit
import ARNTransitionAnimator
import Foundation
import MediaPlayer

class ArticleContainerViewController:UIViewController{

    // MARK: UI Properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet fileprivate(set) weak var tabBar : UITabBar!
 
    // MARK: UI COMPONENTS
    let progressSlide:UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.setThumbImage(UIImage(), for: .normal)
         slider.addTarget(self, action: #selector(ArticleContainerViewController.sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    let bottomAudioView:AudioToolBar = {
        let audioBar = AudioToolBar()
        audioBar.backgroundColor = .black
        audioBar.playBtn.addTarget(self, action: #selector(togglePlayButton), for: .touchUpInside)
        audioBar.backTrackBtn.addTarget(self, action: #selector(backTrackPressded), for: .touchUpInside)
        audioBar.forwardTrackBtn.addTarget(self, action: #selector(fwdTrackPressded), for: .touchUpInside)
        return audioBar
    }()
    
    let audioButtonPressed:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapMiniPlayerButton), for: .touchUpInside)
        return button
    }()

    // MARK: PROPERTIES
    //?? will be fetching audio articles from the server.
    
    
    var audioList:[String] = ["https://s3-ap-northeast-1.amazonaws.com/tl-media-ios-tempfile/b0328.mp3","https://s3-ap-northeast-1.amazonaws.com/tl-media-ios-tempfile/diner-orange.mp3","https://s3-ap-northeast-1.amazonaws.com/tl-media-ios-tempfile/oyster.mp3"]
    
    var nowPlaying:Bool?
    var activeModel:ArticleModel?

    
    var animator : ARNTransitionAnimator?
    fileprivate var modalVC : ArticleModalController!
    
    enum storyboardID:String{
        case storyBoardName = "HOME"
        case storyBoardWithIdentier = "HomeModal"
    }
    let appTitle = "TABI LABO"
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
     
        //navigation bar
        self.navigationItem.title = appTitle
        hideUI()
        
        // MARK: Notification center
        
        //Notification observer to unhide bottomAudioView
        NotificationCenter.default.addObserver(self, selector: #selector(unhideBottomAudio(_:)), name: Notification.Name(notificationCalls.playAudioArticlePressed.rawValue), object: nil)
        
        //Notification observer to be notified of NowPlaying status change.
        NotificationCenter.default.addObserver(self, selector: #selector(notifyNowPlayingStatus(_:)), name: Notification.Name(notificationCalls.nowPlayingStatus.rawValue), object: nil)
        
        let storyboard = UIStoryboard(name: storyboardID.storyBoardName.rawValue, bundle: nil)
        self.modalVC = storyboard.instantiateViewController(withIdentifier: storyboardID.storyBoardWithIdentier.rawValue) as? ArticleModalController
        self.modalVC.modalPresentationStyle = .overFullScreen
        
        //miniplayer properties
        self.containerView.backgroundColor = .white
        //self.setupAnimator()  //turned off for now.  Buggy.
        
        setupView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test playlist", style: .plain, target: self, action: #selector(testPlayList))
        //test code
    }
    
    // MARK: *** TEST CODE ***
    @objc func testPlayList(){
        print("test playlist pressed")
        
        playPlayList()
    }
    // TEST CODE
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    // MARK: ACTION
    @IBAction func tapMiniPlayerButton() {
        let articleDetails = ArticleHeader(id: "1", description: (activeModel?.title[0])!, issueDate: "2017/19/12")
        modalVC.nowPlaying = nowPlaying
        modalVC.header = articleDetails
        self.present(self.modalVC, animated: true, completion: nil)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!){
        print("slider changed")
        let changedTime = Double(progressSlide.value)
        let cmTime = Int64(changedTime * 1000 as Float64)
        PlayListPlayer.shared.seek(to: Float(cmTime))
    }
    
    @objc func notifyNowPlayingStatus(_ notification:Notification){
        guard let nowPlayingStatus = notification.userInfo![notificationCalls.nowPlayingStatus.rawValue] else { return }
        
        //received article detail from NotificationCenter
        nowPlaying = nowPlayingStatus as? Bool
        viewWillAppear(true)
    }
    
    @objc func unhideBottomAudio(_ notification:Notification){
        guard let articleDetails = notification.userInfo![notificationCalls.articleDetails.rawValue] else { return }
        
        //received article detail from NotificationCenter
        activeModel = articleDetails as? ArticleModel
        guard let activeModel = activeModel else {return}
        
        bottomAudioView.titleLabel.text = activeModel.title[0]
        
        let random = Int(arc4random_uniform(3))
        guard let thisURL = URL(string: audioList[random]) else {return}
        PlayListPlayer.shared.set(playList: [thisURL])
        PlayListPlayer.shared.play()

        nowPlaying = true
        unHideUI()
        syncProgressLineToAudio()
    }
    
    @objc func verifyPlayButton(){
        guard let nowPlaying = nowPlaying else {return}
        if (nowPlaying) {
            //set to pause image

        } else {
            //set to play image

        }
    }
    
    @objc func togglePlayButton(){
        guard let nowPlaying = nowPlaying else {return}
        
        if (!nowPlaying) {
            PlayListPlayer.shared.play()
            self.nowPlaying = true
            syncProgressLineToAudio()
        } else {
            PlayListPlayer.shared.pause()
            self.nowPlaying = false
            syncProgressLineToAudio()
        }
    }
    
    @objc func backTrackPressded(){
        print("back pressed")
        PlayListPlayer.shared.jumpToPreviousTrack()
    }
    
    @objc func fwdTrackPressded(){
        print("fwd pressed")
        PlayListPlayer.shared.skipToNextTrack()
    }
    
    // MARK: ASSIST METHODS
    func hideUI(){
        let trueValue = true
        bottomAudioView.isHidden = trueValue
        progressSlide.isHidden = trueValue
    }
    
    func unHideUI(){
        let falseValue = false
        bottomAudioView.isHidden = falseValue
        progressSlide.isHidden = falseValue
    }
    
    func setupView(){
        view.addSubview(bottomAudioView)
        bottomAudioView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 00, width: view.frame.width, height: 85)
        
        //progressSlide
        view.addSubview(progressSlide)
        progressSlide.anchor(top: nil, left: view.leftAnchor, bottom: bottomAudioView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 5)
        
        // Assing values to UI components.
        if let title = activeModel?.title[0] {
            bottomAudioView.titleLabel.text = title
            //bottomAudioView.issueLabel.text = "2017/19/12"
        }
        verifyPlayButton()
    }
    
//    func setupAnimator() {
//        let animation = MusicPlayerTransitionAnimation(rootVC: self, modalVC: self.modalVC)
//        animation.completion = { [weak self] isPresenting in
//            if isPresenting {
//                guard let _self = self else { return }
//                let modalGestureHandler = TransitionGestureHandler(targetVC: _self, direction: .bottom)
//                modalGestureHandler.registerGesture(_self.modalVC.view)
//                modalGestureHandler.panCompletionThreshold = 15.0
//                _self.animator?.registerInteractiveTransitioning(.dismiss, gestureHandler: modalGestureHandler)
//            } else {
//                self?.setupAnimator()
//            }
//        }
//
//        let gestureHandler = TransitionGestureHandler(targetVC: self, direction: .top)
//        gestureHandler.registerGesture(self.bottomAudioView)
//        gestureHandler.panCompletionThreshold = 15.0
//
//        self.animator = ARNTransitionAnimator(duration: 0.5, animation: animation)
//        self.animator?.registerInteractiveTransitioning(.present, gestureHandler: gestureHandler)
//
//        self.modalVC.transitioningDelegate = self.animator
//    }
    
    func syncProgressLineToAudio(){
        //progress code
        PlayListPlayer.shared.player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 30), queue: .main) { time in
            let fraction = CMTimeGetSeconds(time) / CMTimeGetSeconds((PlayListPlayer.shared.player.currentItem?.duration)!)
            self.progressSlide.value = Float(fraction)
        }
    }
    
    func getProgressLineStatus(){
        //progress line logic
        let floatTime = Float(CMTimeGetSeconds((PlayListPlayer.shared.player.currentTime())))
        let durationTime = Float(CMTimeGetSeconds((PlayListPlayer.shared.player.currentItem?.duration)!))
        progressSlide.setValue(floatTime/durationTime, animated: true)
    }
    
    // MARK: ***   test code   ***
    let voice:[String] = ["https://s3-ap-northeast-1.amazonaws.com/tl-media-ios-tempfile/b0328.mp3","https://s3-ap-northeast-1.amazonaws.com/tl-media-ios-tempfile/diner-orange.mp3","https://s3-ap-northeast-1.amazonaws.com/tl-media-ios-tempfile/oyster.mp3"]
    
    
    
    
    func  playPlayList(){
        //create playlist
        let voiceArticleOne:PlayListItem = PlayListItem(title: "one", url: voice[0])
        let voiceArticleTwo:PlayListItem = PlayListItem(title: "two", url: voice[1])
        let voiceArticleThree:PlayListItem = PlayListItem(title: "three", url: voice[2])

//        let playListName = "Hanami"
//        var testPlaylist = PlayList(name: playListName, item: voiceArticleOne)
//        testPlaylist.addPlayListItem(name:playListName , item: voiceArticleTwo)
//        testPlaylist.addPlayListItem(name: playListName, item: voiceArticleThree)
        
        let url1: URL = URL(string: voiceArticleOne.url)!
        let url2: URL = URL(string: voiceArticleTwo.url)!
        let url3: URL = URL(string: voiceArticleThree.url)!
        PlayListPlayer.shared.set(playList: [url1, url2, url3])

        
        //start playing
        PlayListPlayer.shared.play()
        nowPlaying = true
        unHideUI()
        syncProgressLineToAudio()
        
    }
    //***   test code   ***
}


