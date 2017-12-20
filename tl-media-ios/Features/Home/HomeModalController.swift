//
//  HomeModalController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/14.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
// The secondary viewController of the primary Container View Controller.

import UIKit

class HomeModalController:UIViewController {

    // MARK: UI COMPONENTS
    let topController:AudioToolBar = {
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
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    //BLOCKS SENDER AND MESSAGEBOX
    let blockSendButton:UIView = {
        let ui = UIView()
        ui.backgroundColor = .black
        return ui
    }()
    
    let progressSlide:UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.setThumbImage(UIImage(), for: .normal)
        return slider
    }()
    
    //AudioControls
    let ccButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(ccPressed), for: .touchUpInside)
        return button
    }()
    
    let rewindButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(rewindPressed), for: .touchUpInside)
        button.backgroundColor = .green
        return button
    }()
    
    let pausePlayButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        button.contentMode = .center
        button.addTarget(self, action: #selector(pausePlayPressed), for: .touchUpInside)
        return button
    }()
    
    let forwardButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(forwardPressed), for: .touchUpInside)
         button.backgroundColor = .orange
        return button
    }()
    
    let replayButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(replayPressed), for: .touchUpInside)
        button.backgroundColor = .yellow
        return button
    }()
    
    // MARK: PROPERTIES
    var audioManager:HomeAudio?
    var nowPlaying:Bool?
    var header:ArticleHeader?
    
    // MARK: OUTLETS
    @IBOutlet weak var audioChat: UIView!
    
    // MARK: LIFECYLE
    override func viewDidLoad() {
       setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }

    // MARK: ACTION
    @objc private func startAudio(){
        audioManager = HomeAudio.shared
        
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
    
    @objc private func dismissView(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func audioControlPressed(){
        print("audio control button pressed")
    }
    
    @objc private func ccPressed(){
        print("cc button pressed.")
        audioChat.isHidden = !audioChat.isHidden
    }

    @objc private func rewindPressed(){
        print("rewind button pressed.")
        audioManager?.back15()
    }
    
    @objc private func pausePlayPressed(){
        print("pause play button pressed.")
        startAudio()
    }
    
    @objc private func forwardPressed(){
        print("forward button pressed.")
        audioManager?.foward15()
    }
    
    @objc private func replayPressed(){
        print("replay button pressed.")
        audioManager?.resetAudio()
    }
    // MARK: ASSIST METHODS
    private func setupView(){
        view.backgroundColor = .black
        audioChat.backgroundColor = .black
        
        //**top audio control**
        let topBottomPadding:CGFloat = 15
        view.addSubview(topController)
        topController.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 85)
        
        //play~pause button
        topController.addSubview(playPauseButton)
        playPauseButton.anchor(top: topController.topAnchor, left: nil, bottom: topController.bottomAnchor, right: topController.rightAnchor, paddingTop: topBottomPadding, paddingLeft: 0, paddingBottom: -topBottomPadding, paddingRight: -50, width: 150, height:150)

        //invisible button to dismiss
        topController.addSubview(dismissButton)
        dismissButton.anchor(top: topController.topAnchor, left: topController.leftAnchor, bottom: topController.bottomAnchor, right: playPauseButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        //**Chat message display**
        view.addSubview(audioChat)
        audioChat.anchor(top: topController.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 550)

        audioChat.addSubview(blockSendButton)
        blockSendButton.anchor(top: nil, left: audioChat.leftAnchor, bottom: audioChat.bottomAnchor, right: audioChat.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: audioChat.frame.width, height: 50)

        //progressSlide
        view.addSubview(progressSlide)
        progressSlide.anchor(top: nil, left: view.leftAnchor, bottom: blockSendButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 5)
        
        setupAudioControls()
        
        //Enter details of UI Component
        topController.titleLabel.text = header?.description
        topController.issueLabel.text = header?.issueDate
    }
    
    private func setupAudioControls(){
        let stackView = UIStackView(arrangedSubviews: [ccButton,rewindButton,pausePlayButton,forwardButton,replayButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: progressSlide.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
    }
}
