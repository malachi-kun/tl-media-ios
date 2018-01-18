//
//  FacebookLoginDetail.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2018/01/05.
//  Copyright © 2018 Tabi-Labo. All rights reserved.
//
//  THIS IS A CODE SANDBOX, NOT BEING USED...

import UIKit
import FacebookLogin
import FacebookCore

class FacebookService:UIViewController,LoginButtonDelegate{
    
    // MARK: UI COMPONENTS
    let facebookLogin:LoginButton = {
        let fbButton = LoginButton(readPermissions: [.publicProfile, .email])
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        return fbButton
    }()
    
    // MARK: FACEBOOK SHARE SERVICE
    private func facebookShare(){
        let url = URL(string: "http://tabi-labo.com")
        let activityController  = UIActivityViewController(activityItems: ["test", #imageLiteral(resourceName: "TL"), url ?? nil], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    // MARK: FACEBOOK LOGINBUTTON DELEGATE
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email,name"])) { httpResponse, result in
            switch result {
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
                self.facebookShare()
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logout success")
    }
    
}
