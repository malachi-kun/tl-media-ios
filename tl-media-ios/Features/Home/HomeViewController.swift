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

class HomeViewController:UIViewController{

    // MARK: UIProperties
    @IBOutlet weak var bottomAudioView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet fileprivate(set) weak var tabBar : UITabBar!
    @IBOutlet weak var btnPlay: UIButton!
    
    //MANUAL AUDIO BAR CODE
    // MARK: UI COMPONENTS
    let bottomControllerView:UIView = {
        let topView = UIView()
        topView.backgroundColor = .white
        return topView
    }()
    
    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TL")
        return iv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Article Title \nsecond line"
        label.font = UIFont.systemFont(ofSize: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        //label.backgroundColor = .green
        return label
    }()
    
    let issueLabel:UILabel = {
        let label = UILabel()
        label.text = "ISSUE 2017/12/18"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let playPauseButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        return button
    }()
    //MANUAL AUDIO BAR CODE
    
    //?? will be fetching audio articles from the server.
    var audioURLList:[String] = ["http://techslides.com/demos/samples/sample.mp3"]
    var audioManager:HomeAudio?
    var nowPlaying:Bool?
    
    private var animator : ARNTransitionAnimator?
    fileprivate var modalVC : HomeModalController!
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        bottomAudioView.isHidden = true
        
        //initialize audio
        audioManager = HomeAudio(fileURL: audioURLList[0])
        
        // MARK: Notification center
        //add Notification observer to unhide bottomAudioView
        NotificationCenter.default.addObserver(self, selector: #selector(unhideBottomAudio), name: Notification.Name(notificationCalls.playAudioArticlePressed.rawValue), object: nil)
        
        let storyboard = UIStoryboard(name: "HOME", bundle: nil)
        self.modalVC = storyboard.instantiateViewController(withIdentifier: "HomeModal") as? HomeModalController
        self.modalVC.modalPresentationStyle = .overFullScreen
        
        //miniplayer properties
        self.containerView.backgroundColor = .white
        self.setupAnimator()
        
        //setupView()
    }
    
    @objc func unhideBottomAudio(){
        bottomAudioView.isHidden = false
        startAudio()
    }
    
    // MARK: ACTION
    @IBAction func tapMiniPlayerButton() {
        print("button pressed")
        self.present(self.modalVC, animated: true, completion: nil)
    }
    
    @IBAction func btnPlayPressed(_ sender: Any) {
        startAudio()
    }
    
    private func startAudio(){
        guard let nowPlaying = nowPlaying else {
            audioManager?.playAudio()
            self.nowPlaying = true
            btnPlay.setTitle("| |", for: .normal)
            return
        }
        
        //Need to fix below
        if (!nowPlaying) {
            audioManager?.playAudio()
            self.nowPlaying = true
            btnPlay.setTitle("| |", for: .normal)
        } else {
            audioManager?.pauseAudio()
            self.nowPlaying = false
            btnPlay.setTitle("|>", for: .normal)
        }
    }
    
    // MARK: ASSIST METHODS
    private func setupView(){
        view.addSubview(bottomControllerView)
        bottomAudioView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 09, width: view.frame.width, height: 85)
        
        //title label
        bottomAudioView.addSubview(titleLabel)
        let topBottomPadding:CGFloat = 15
        let leftPadding:CGFloat = 15
        let labelWidth:CGFloat = 250
        titleLabel.anchor(top: bottomAudioView.topAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: leftPadding, paddingBottom:0, paddingRight: 0, width: labelWidth, height: 45)
        
        //issue label
        bottomAudioView.addSubview(issueLabel)
        issueLabel.anchor(top: titleLabel.bottomAnchor, left: articleImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: leftPadding, paddingBottom:0, paddingRight: 0, width: labelWidth, height: 15)
        
        //play~pause button
        bottomAudioView.addSubview(playPauseButton)
        playPauseButton.anchor(top: bottomAudioView.topAnchor, left: nil, bottom: bottomAudioView.bottomAnchor, right: bottomAudioView.rightAnchor, paddingTop: topBottomPadding, paddingLeft: 0, paddingBottom: -topBottomPadding, paddingRight: -50, width: 150, height:150)
        //**top audio control**
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
}


