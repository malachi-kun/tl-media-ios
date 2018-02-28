//
//  MusicPlayerTransitionAnimation.swift
//  MusicPlayerTransition
//
//  Created by xxxAIRINxxx on 2016/11/05.
//  Copyright © 2016 xxxAIRINxxx. All rights reserved.
//  Published by Malachi Hul

import Foundation
import UIKit
import ARNTransitionAnimator

final class MusicPlayerTransitionAnimation : TransitionAnimatable {
    
    fileprivate var rootVC: ArticleContainerViewController!
    fileprivate weak var modalVC: ArticleModalController!
    @IBOutlet fileprivate(set) weak var tabBar : UITabBar!
    
    var completion: ((Bool) -> Void)?
    
    private var miniPlayerStartFrame: CGRect
    private var tabBarStartFrame: CGRect
    private var containerView: UIView?
    
    deinit {
        print("deinit MusicPlayerTransitionAnimation")
    }
    
    init(rootVC: ArticleContainerViewController, modalVC: ArticleModalController) {
        self.rootVC = rootVC
        self.modalVC = modalVC
        
        self.miniPlayerStartFrame = rootVC.bottomAudioView.frame
        self.tabBarStartFrame = rootVC.tabBar.frame
    }
    
    // @see : http://stackoverflow.com/questions/25588617/ios-8-screen-blank-after-dismissing-view-controller-with-custom-presentation
    func prepareContainer(_ transitionType: TransitionType, containerView: UIView, from fromVC: UIViewController, to toVC: UIViewController) {
        self.containerView = containerView
        if transitionType.isPresenting {
//            self.modalVC.view.removeFromSuperview()
            self.rootVC.view.insertSubview(self.modalVC.view, belowSubview: self.rootVC.tabBar)
        } else {
//            self.modalVC.view.removeFromSuperview()
            self.rootVC.view.insertSubview(self.modalVC.view, belowSubview: self.rootVC.tabBar)
        }
        self.rootVC.view.setNeedsLayout()
        self.rootVC.view.layoutIfNeeded()
        self.modalVC.view.setNeedsLayout()
        self.modalVC.view.layoutIfNeeded()
        
        self.miniPlayerStartFrame = self.rootVC.bottomAudioView.frame
        self.tabBarStartFrame = self.rootVC.tabBar.frame
    }
    
    func willAnimation(_ transitionType: TransitionType, containerView: UIView) {
        if transitionType.isPresenting {
            self.rootVC.beginAppearanceTransition(true, animated: false)
            
            self.modalVC.view.frame.origin.y = self.rootVC.bottomAudioView.frame.origin.y + self.rootVC.bottomAudioView.frame.size.height
        } else {
            self.rootVC.beginAppearanceTransition(false, animated: false)
            
            self.rootVC.bottomAudioView.alpha = 1.0
            self.rootVC.bottomAudioView.frame.origin.y = -self.rootVC.bottomAudioView.bounds.size.height
            self.rootVC.tabBar.frame.origin.y = containerView.bounds.size.height
        }
    }
    
    func updateAnimation(_ transitionType: TransitionType, percentComplete: CGFloat) {
        if transitionType.isPresenting {
            // miniPlayerView
            let startOriginY = self.miniPlayerStartFrame.origin.y
            let endOriginY = -self.miniPlayerStartFrame.size.height
            let diff = -endOriginY + startOriginY
            //print("startOrigin:\(startOriginY) endOrigin:\(endOriginY) diff:\(diff)")
            // tabBar
            let tabStartOriginY = self.tabBarStartFrame.origin.y
            let tabEndOriginY = self.modalVC.view.frame.size.height
            let tabDiff = tabEndOriginY - tabStartOriginY
            
            let playerY = startOriginY - (diff * percentComplete)
            self.rootVC.bottomAudioView.frame.origin.y = max(min(playerY, self.miniPlayerStartFrame.origin.y), endOriginY)

            self.modalVC.view.frame.origin.y = self.rootVC.bottomAudioView.frame.origin.y + self.rootVC.bottomAudioView.frame.size.height
            let tabY = tabStartOriginY + (tabDiff * percentComplete)
            self.rootVC.tabBar.frame.origin.y = min(max(tabY, self.tabBarStartFrame.origin.y), tabEndOriginY)
            
            let alpha = 1.0 - (1.0 * percentComplete)
            self.rootVC.containerView.alpha = alpha + 0.5
            self.rootVC.tabBar.alpha = alpha
        } else {
            // miniPlayerView
            let startOriginY = 0 - self.rootVC.bottomAudioView.bounds.size.height
            let endOriginY = self.miniPlayerStartFrame.origin.y + 70
            let diff = -startOriginY + endOriginY
            // tabBar
            let tabStartOriginY = self.rootVC.containerView.bounds.size.height
            let tabEndOriginY = self.tabBarStartFrame.origin.y
            let tabDiff = tabStartOriginY - tabEndOriginY
            
            self.rootVC.bottomAudioView.frame.origin.y = startOriginY + (diff * percentComplete)
            self.modalVC.view.frame.origin.y = self.rootVC.bottomAudioView.frame.origin.y + self.rootVC.bottomAudioView.frame.size.height
            
            self.rootVC.tabBar.frame.origin.y = tabStartOriginY - (tabDiff *  percentComplete)
            
            let alpha = 1.0 * percentComplete
            self.rootVC.containerView.alpha = alpha + 0.5
            self.rootVC.tabBar.alpha = alpha
            self.rootVC.bottomAudioView.alpha = 1.0
        }
    }
    
    func finishAnimation(_ transitionType: TransitionType, didComplete: Bool) {
        self.rootVC.endAppearanceTransition()
        
        if transitionType.isPresenting {
            if didComplete {
                self.rootVC.bottomAudioView.alpha = 0.0
                self.modalVC.view.removeFromSuperview()
                self.containerView?.addSubview(self.modalVC.view)
                
                self.completion?(transitionType.isPresenting)
            } else {
                self.rootVC.beginAppearanceTransition(true, animated: false)
                self.rootVC.endAppearanceTransition()
            }
        } else {
            if didComplete {
                self.modalVC.view.removeFromSuperview()
                
                self.completion?(transitionType.isPresenting)
            } else {
                self.rootVC.bottomAudioView.alpha = 0.0
                
                self.modalVC.view.removeFromSuperview()
                self.containerView?.addSubview(self.modalVC.view)
                
                self.rootVC.beginAppearanceTransition(false, animated: false)
                self.rootVC.endAppearanceTransition()
            }
        }
    }
}

extension MusicPlayerTransitionAnimation {
    
    func sourceVC() -> UIViewController { return self.rootVC }
    
    func destVC() -> UIViewController { return self.modalVC }
}


