//
//  NetworkManager.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/28.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit
import Foundation

protocol ArticleContentDelegate{
    func articleContentList(articleModelList:[ArticleContentModel], articleContentModelList:[Int:[ArticleContentModel]])
}

class NetworkManager {
    
    // MARK: PROPERTIES
    var delegate:ArticleContentDelegate?
    
    var articleIDs = [Int]()
    var fetchedArticleContent = [ArticleContentModel]()
    var articleDict = [Int:[ArticleContentModel]]()
    
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
        var input_type:String
    }
    
    //Server endpoint
    enum authHeader:String{
        case authType = "Authorization"
        case authString = "Bearer 18ea0f254ce9bef70b6d95e10b03c6c36d9e4155c1fcc2322f69ab92c52069d2"
        case url = "https://cms-api-dev.tabi-labo.com/api/v1/article"
        case prodUrl = "https://search-tl-search-dev-bvb77sqhuziebbdvilw5qem5uy.ap-northeast-1.cloudsearch.amazonaws.co"
    }
    
    // MARK: LIFECYCLE
    init(){
        getArticleFromServer(id: nil, last:nil)
    }
    
    // MARK: GET URL FOR ARTICLE INFORMATION FROM SERVER.
    //If an 'id' is present.  Use URL to get Article Content.
    //If no 'id' is present.  Use URL to get Article ID.
    //Get data from server
    func getArticleFromServer(id:Int?, last:Bool?){
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [authHeader.authType.rawValue : authHeader.authString.rawValue]
    
        let session = URLSession(configuration: config)
        
        //If ID is present, we will want to fetch article content.  Else we are just fetching for articleIDs
        if let id = id {
            let address = "\(authHeader.url.rawValue)/\(id)"
            guard let url = NSURL(string: address) else { return }
            self.fetch(url: url, session: session, content:true, id:id, last:last)
        } else {
            guard let url = NSURL(string: authHeader.url.rawValue) else { return }
            self.fetch(url: url, session: session, content: false, id: nil, last:nil)
        }
    }
    
    //If an 'Content' is true.  Fetch Article Content.
    //If an 'Content' is false.  Fetch Article ID.
    private func fetch(url:NSURL, session:URLSession, content:Bool, id:Int?, last:Bool?){
        let task = session.dataTask(with: url as URL) {
            (data, response, error) in
            
            //Check for successful server connection and data received.  Send to parse data
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data {
                if content {
                    guard let id = id else {return}
                    self.parseJSONForArticleContent(data: responseData, id: id, last: nil)
                    
                    guard let last = last else {return}
                    if last {
                        self.delegate?.articleContentList(articleModelList: self.fetchedArticleContent, articleContentModelList: self.articleDict)
                    }
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
            
            //print("Completed ID Fetch.  ID Count: \(articleIDs.count)")
        }catch let error{
            //print("unable to create json object. \n Error: \(error)")
        }
    }
    
    //Fetch Article Content with ID
    private func fetchContentFromID(){
        
        for i in 0..<articleIDs.count {

            if i != articleIDs.count - 1{
                getArticleFromServer(id: articleIDs[i], last: nil)
            } else {
                getArticleFromServer(id: articleIDs[i], last: true)
            }
        }
    }
    
    //Parse Article Content with IDs
    func parseJSONForArticleContent(data:Data, id:Int, last:Bool?){
        do{
            //decode for article content
            let jsonDecoded = try JSONDecoder().decode(articleContentList.self, from: data)
            
            guard let articleItems = jsonDecoded.article_items else {return}
            for article in articleItems{
                //print("id:\(id), content:\(article.content), input:\(article.input_type)")
                let articleContent = ArticleContentModel(id:id , content: article.content, input:article.input_type)
                fetchedArticleContent.append(articleContent)
            }
            
            //Add to dictionary to organize data
            articleDict = [id:fetchedArticleContent]
            //print("Completed Article Content Fetching. Fetch count.")
            
        }catch {
            print("unable to create json object. \n Error: (error)")
        }
    }
    
    //Parse article content for images
    //** TBA **
}