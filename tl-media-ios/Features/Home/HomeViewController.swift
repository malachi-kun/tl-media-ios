//
//  HomeViewController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/14.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
// The initial view controller that holds the HomeRootViewController and BottonAudioBar

import UIKit
import ARNTransitionAnimator
import Foundation
import MediaPlayer

class HomeViewController:UIViewController{

    // MARK: UIProperties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet fileprivate(set) weak var tabBar : UITabBar!
 
    // MARK: UI COMPONENTS
    let progressSlide:UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
         slider.addTarget(self, action: #selector(HomeViewController.sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    

    let bottomAudioView:AudioToolBar = {
        let top = AudioToolBar()
        top.backgroundColor = .white
        return top
    }()
    
    let playPauseButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
        button.addTarget(self, action: #selector(togglePlayButton), for: .touchUpInside)
        
        return button
    }()

    let audioButtonPressed:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapMiniPlayerButton), for: .touchUpInside)
        return button
    }()

    // MARK: PROPERTIES
    //?? will be fetching audio articles from the server.
    var audioURLList:[String] = ["http://techslides.com/demos/samples/sample.mp3"]
    var audioManager:HomeAudio?
    var nowPlaying:Bool?
    var activeModel:ArticleModel?
    
    private var animator : ARNTransitionAnimator?
    fileprivate var modalVC : HomeModalController!
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
     
        //navigation bar
        self.navigationItem.title = "TABI LABO"
        hideUI()
        
        // MARK: Notification center
        //Notification observer to unhide bottomAudioView
        NotificationCenter.default.addObserver(self, selector: #selector(unhideBottomAudio(_:)), name: Notification.Name(notificationCalls.playAudioArticlePressed.rawValue), object: nil)
        //Notification observer to be notified of NowPlaying status change.
        NotificationCenter.default.addObserver(self, selector: #selector(notifyNowPlayingStatus(_:)), name: Notification.Name(notificationCalls.nowPlayingStatus.rawValue), object: nil)
        
        let storyboard = UIStoryboard(name: "HOME", bundle: nil)
        self.modalVC = storyboard.instantiateViewController(withIdentifier: "HomeModal") as? HomeModalController
        self.modalVC.modalPresentationStyle = .overFullScreen
        
        //miniplayer properties
        self.containerView.backgroundColor = .white
        //self.setupAnimator()  //turned off for now.  Buggy.
        
        setupView()
    }
    
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
        let cmTime = CMTimeMake(Int64(changedTime * 1000 as Float64), 1000)
        audioManager?.avPlayer?.seek(to: cmTime)
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
        audioManager = HomeAudio.shared
        nowPlaying = true
        unHideUI()
        syncProgressLineToAudio()
    }
    
    @objc private func verifyPlayButton(){
        guard let nowPlaying = nowPlaying else {return}
        if (nowPlaying) {
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    @objc private func togglePlayButton(){
        guard let nowPlaying = nowPlaying else {return}
        
        if (!nowPlaying) {
            audioManager?.playAudio()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause.png"), for: .normal)
            self.nowPlaying = true
            syncProgressLineToAudio()
        } else {
            audioManager?.pauseAudio()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            self.nowPlaying = false
            syncProgressLineToAudio()
        }
    }
    
    // MARK: ASSIST METHODS
    private func hideUI(){
        let trueValue = true
        bottomAudioView.isHidden = trueValue
        progressSlide.isHidden = trueValue
    }
    
    private func unHideUI(){
        let falseValue = false
        bottomAudioView.isHidden = falseValue
        progressSlide.isHidden = falseValue
    }
    
    private func setupView(){
        view.addSubview(bottomAudioView)
        let topBottomPadding:CGFloat = 15
        bottomAudioView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -80, paddingRight: 00, width: view.frame.width, height: 85)
        
        //progressSlide
        view.addSubview(progressSlide)
        progressSlide.anchor(top: nil, left: view.leftAnchor, bottom: bottomAudioView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 5)
        
        //play~pause button
        bottomAudioView.addSubview(playPauseButton)
        playPauseButton.anchor(top: bottomAudioView.topAnchor, left: nil, bottom: bottomAudioView.bottomAnchor, right: bottomAudioView.rightAnchor, paddingTop: topBottomPadding, paddingLeft: 0, paddingBottom: -topBottomPadding, paddingRight: -50, width: 150, height:150)

        //invisible button to activate
        bottomAudioView.addSubview(audioButtonPressed)
        audioButtonPressed.anchor(top: bottomAudioView.topAnchor, left: bottomAudioView.leftAnchor, bottom: view.bottomAnchor, right: playPauseButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -10, paddingRight: 0, width: 0, height: 0)
    
        // Assing values to UI components.
        if let title = activeModel?.title[0] {
            bottomAudioView.titleLabel.text = title
            bottomAudioView.issueLabel.text = "2017/19/12"
        }
        verifyPlayButton()
    }
    
    func setupAnimator() {
        let animation = MusicPlayerTransitionAnimation(rootVC: self, modalVC: self.modalVC)
        animation.completion = { [weak self] isPresenting in
            if isPresenting {
                guard let _self = self else { return }
                let modalGestureHandler = TransitionGestureHandler(targetVC: _self, direction: .bottom)
                modalGestureHandler.registerGesture(_self.modalVC.view)
                modalGestureHandler.panCompletionThreshold = 15.0
                _self.animator?.registerInteractiveTransitioning(.dismiss, gestureHandler: modalGestureHandler)
            } else {
                self?.setupAnimator()
            }
        }
        
        let gestureHandler = TransitionGestureHandler(targetVC: self, direction: .top)
        gestureHandler.registerGesture(self.bottomAudioView)
        gestureHandler.panCompletionThreshold = 15.0
        
        self.animator = ARNTransitionAnimator(duration: 0.5, animation: animation)
        self.animator?.registerInteractiveTransitioning(.present, gestureHandler: gestureHandler)
        
        self.modalVC.transitioningDelegate = self.animator
    }
    

    
    private func syncProgressLineToAudio(){
        //progress code
        audioManager?.avPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 30), queue: .main) { time in
            let fraction = CMTimeGetSeconds(time) / CMTimeGetSeconds((self.audioManager?.avPlayer?.currentItem!.duration)!)
            self.progressSlide.value = Float(fraction)
        }
    }
    

    
    private func getProgressLineStatus(){
        //progress line logic
        let floatTime = Float(CMTimeGetSeconds((audioManager?.avPlayer?.currentTime())!))
        let durationTime = Float(CMTimeGetSeconds((audioManager?.avPlayer?.currentItem?.duration)!))
        progressSlide.setValue(floatTime/durationTime, animated: true)
    }
}


