//
//  LoginBaseController.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/04.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//

import UIKit

class TrainingBaseController:UIViewController {
    // MARK: UI COMPONENTS
    
    let logoImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "LOGO")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let enjoyTabiLaboImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "HowToEnjoyTabiLabo")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    

    override func viewDidLoad() {
        view.backgroundColor = UIColor(displayP3Red: 31, green: 31, blue: 31, alpha: 0.1)
        setupUI()
    }
    

    // MARK: ASSIST METHODS
    private func setupUI(){
        view.backgroundColor = UIColor(displayP3Red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
        
        centerTabiLaboIcon()
        
        view.addSubview(enjoyTabiLaboImageView)
        enjoyTabiLaboImageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 156, height: 88)
        enjoyTabiLaboImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    private func centerTabiLaboIcon(){
        //Tabi Labo Icon in the center
        view.addSubview(logoImageView)
        logoImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
