//
//  HomeViewController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/12/14.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit
import ARNTransitionAnimator
import Foundation

class HomeViewController:UIViewController{

    // MARK: UIProperties
    @IBOutlet weak var bottomAudioView: HomeLineView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet fileprivate(set) weak var tabBar : UITabBar!
    
    private var animator : ARNTransitionAnimator?
    fileprivate var modalVC : HomeModalController!
    

    // MARK: LIFECYCLE
    override func viewDidLoad() {
        bottomAudioView.isHidden = true
        
        let storyboard = UIStoryboard(name: "HOME", bundle: nil)
        self.modalVC = storyboard.instantiateViewController(withIdentifier: "HomeModal") as? HomeModalController
        self.modalVC.modalPresentationStyle = .overFullScreen
        
        //miniplayer properties
        self.containerView.backgroundColor = .white
        let color = UIColor.white  //color when miniPlaybutton is click action.
        
        self.setupAnimator()
        
        setupView()
    }
    
    
    // MARK: ACTION
    @IBAction func tapMiniPlayerButton() {
        print("button pressed")
        self.present(self.modalVC, animated: true, completion: nil)
    }
    
    
    // MARK: ASSIST METHODS
    private func setupView(){
        bottomAudioView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -75, paddingRight: 0, width: view.frame.size.width, height: 50)
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


