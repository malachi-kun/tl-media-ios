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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet fileprivate(set) weak var tabBar : UITabBar!
 
    // MARK: UI COMPONENTS
    let bottomAudioView:AudioToolBar = {
        let top = AudioToolBar()
        top.backgroundColor = .white
        return top
    }()
    
    let playPauseButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        button.addTarget(self, action: #selector(startAudio), for: .touchUpInside)
        return button
    }()

    let dismissButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapMiniPlayerButton), for: .touchUpInside)
        return button
    }()

    
    // MARK: PROPERTIES
    //let articleHeaderDetails:ArticleHeader?  //mark for delete: 2017/12/19
    
    //?? will be fetching audio articles from the server.
    var audioURLList:[String] = ["http://techslides.com/demos/samples/sample.mp3"]
    var audioManager:HomeAudio?
    var nowPlaying:Bool?
    var activeModel:ArticleModel?
    
    private var animator : ARNTransitionAnimator?
    fileprivate var modalVC : HomeModalController!
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {

        bottomAudioView.isHidden = true
        
        // MARK: Notification center
        //add Notification observer to unhide bottomAudioView
        NotificationCenter.default.addObserver(self, selector: #selector(unhideBottomAudio(_:)), name: Notification.Name(notificationCalls.playAudioArticlePressed.rawValue), object: nil)
        
        let storyboard = UIStoryboard(name: "HOME", bundle: nil)
        self.modalVC = storyboard.instantiateViewController(withIdentifier: "HomeModal") as? HomeModalController
        self.modalVC.modalPresentationStyle = .overFullScreen
        
        //miniplayer properties
        self.containerView.backgroundColor = .white
        self.setupAnimator()
        
        setupView()
    }
    
    @objc func unhideBottomAudio(_ notification:Notification){

        guard let articleDetails = notification.userInfo![notificationCalls.articleDetails.rawValue] else { return }
        
        //received article detail from NotificationCenter
        activeModel = articleDetails as? ArticleModel
        guard let activeModel = activeModel else {return}

        bottomAudioView.titleLabel.text = activeModel.title[0]
        bottomAudioView.isHidden = false
        audioManager = HomeAudio.shared
        nowPlaying = true
    }
    
    // MARK: ACTION
    @IBAction func tapMiniPlayerButton() {
  
        let articleDetails = ArticleHeader(id: "1", description: (activeModel?.title[0])!, issueDate: "2017/19/12")
        modalVC.nowPlaying = nowPlaying
        modalVC.header = articleDetails
        print(articleDetails)
        self.present(self.modalVC, animated: true, completion: nil)
    }
    
    @objc private func startAudio(){
        guard let nowPlaying = nowPlaying else {
            audioManager?.playAudio()
            self.nowPlaying = true
            return
        }
        
        //Need to fix below
        if (!nowPlaying) {
            audioManager?.playAudio()
            self.nowPlaying = true
        } else {
            audioManager?.pauseAudio()
            self.nowPlaying = false
        }
    }
    
    // MARK: ASSIST METHODS
    private func setupView(){

        view.addSubview(bottomAudioView)
        let topBottomPadding:CGFloat = 15
        bottomAudioView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -80, paddingRight: 00, width: view.frame.width, height: 85)
        
        //play~pause button
        bottomAudioView.addSubview(playPauseButton)
        playPauseButton.anchor(top: bottomAudioView.topAnchor, left: nil, bottom: bottomAudioView.bottomAnchor, right: bottomAudioView.rightAnchor, paddingTop: topBottomPadding, paddingLeft: 0, paddingBottom: -topBottomPadding, paddingRight: -50, width: 150, height:150)

        //invisible button to activate
        bottomAudioView.addSubview(dismissButton)
        dismissButton.anchor(top: bottomAudioView.topAnchor, left: bottomAudioView.leftAnchor, bottom: bottomAudioView.progressSlide.topAnchor, right: playPauseButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -10, paddingRight: 0, width: 0, height: 0)
    
        // Assing values to UI components.
        if let title = activeModel?.title[0] {
            bottomAudioView.titleLabel.text = title
            bottomAudioView.issueLabel.text = "2017/19/12"
        }
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


