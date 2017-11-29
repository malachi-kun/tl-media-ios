//
//  NetworkManager.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/28.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit
import Foundation

class NetworkManager:Codable {

    // MARK: PROPERTIES
    var articleIDs = [Int]()
    
    //Codable Structure
    //**Article ID
    struct articles:Decodable {
        var articles:[article]
    }
    
    struct article:Decodable {
        var article_id:Int
    }
    
    //**Article Content
    struct articleContentList:Decodable{
        var article_items:[articleContent]?
    }
    
    struct articleContent:Decodable {
        var content:String
        var images:[String]?
    }
    
    //Server endpoint
    enum authHeader:String{
        case authType = "Authorization"
        case authString = "Bearer 18ea0f254ce9bef70b6d95e10b03c6c36d9e4155c1fcc2322f69ab92c52069d2"
        case url = "https://cms-api-dev.tabi-labo.com/api/v1/article"
    }
    
    // MARK: FETCH ARTICLE IDS FROM SERVER
    //Get data from server
    func getArticleFromServer(id:Int?){
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [authHeader.authType.rawValue : authHeader.authString.rawValue]
    
        let session = URLSession(configuration: config)
        
        //If ID is present, we will want to fetch article content.  Else we are just fetching for articleIDs
        if let id = id {
            let address = "\(authHeader.url.rawValue)/\(id)"
            guard let url = NSURL(string: address) else { return }
            self.fetch(url: url, session: session, content:true)
        } else {
            guard let url = NSURL(string: authHeader.url.rawValue) else { return }
            self.fetch(url: url, session: session, content: false)
        }
    }
    
    private func fetch(url:NSURL, session:URLSession, content:Bool){
        let task = session.dataTask(with: url as URL) {
            (data, response, error) in
            
            //Check for successful server connection and data received.
            //Send to parse data
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data {
                if content {
                    self.parseJSONForArticleContent(data: responseData)
                } else {
                    self.parseJSONForArticleID(data: responseData)
                    self.fetchContentFromID()
                }
            }
        }
        task.resume()
    }
    
    //Parse for Article ID
    func parseJSONForArticleID(data:Data){
        //serialize the data
        do{
            //decode and place article IDs in an Array
            let jsonDecoded = try JSONDecoder().decode(articles.self, from: data)
            for article in jsonDecoded.articles {
                articleIDs.append(article.article_id)
            }
            
            print("Completed ID Fetch.  ID Count: \(articleIDs.count)")
        }catch let error{
            print("unable to create json object. \n Error: \(error)")
        }
    }
    
    private func fetchContentFromID(){
        for id in articleIDs {
            getArticleFromServer(id: id)
        }
    }
    
    //Get article content with IDs
    func parseJSONForArticleContent(data:Data){
        do{
            //decode for article content
            let jsonDecoded = try JSONDecoder().decode(articleContentList.self, from: data)
            guard let articleItems = jsonDecoded.article_items else {return}
            for article in articleItems{
                print("Content: \(article.content), Images: \(article.images ?? [""])")
            }
            
            print("Completed ID Fetch.  ID Count: \(articleIDs.count)")
        }catch let error{
            print("unable to create json object. \n Error: \(error)")
        }
    }
    
    //Parse article content for images
    
}
