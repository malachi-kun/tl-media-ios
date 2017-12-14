//
//  NetworkManager.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/28.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//
import UIKit
import Foundation

class HomeNetworking {
    
    // MARK: PROPERTIES
    //delegate prop.
    var delegate:ArticleContentDelegate?, delegateProd:ArticleProdDelegate?
    
    //article prop.
    //var articleIDs = [Int](), fetchedArticleContent = [ArticleContentModel]()
    var articleDict = [Int:[ArticleContentModel]](), articleList = [ArticleModel]()
    
    //Codable Structure
    // MARK: **Article ID**
//    struct articles:Decodable {
//        var articles:[article]
//
//    }
//    struct article:Decodable {
//        var article_id:Int
//
//    }
//
//    //**Article Content
//    struct articleContentList:Decodable{
//        var article_items:[articleContent]?
//
//    }
//
//    struct articleContent:Decodable {
//        var content:String
//        var input_type:String
//    }
    // MARK: **Article ID**
    
    //Server endpoint
    
    enum authHeader:String{
        case authType = "Authorization"
        case authString = "Bearer 18ea0f254ce9bef70b6d95e10b03c6c36d9e4155c1fcc2322f69ab92c52069d2"
        case devUrl = "https://cms-api-dev.tabi-labo.com/api/v1/article"
        case prodUrl = "https://search-tl-search-dev-bvb77sqhuziebbdvilw5qem5uy.ap-northeast-1.cloudsearch.amazonaws.com/2013-01-01/search?q=titles:1&q.parser=structured"
    }
    
    enum env:String{
        case dev
        case prod
    }
    
    //SELECTED ENVIRONMENT
    var environment = env.prod.rawValue  // dev or prod
  

    // MARK: LIFECYCLE
    init(){
        //getArticleFromServer(id: nil, last:nil) //disabled during testing
        getFromProdEndpoint()
    }
    
    // MARK: **PROD Article CODEABLE STRUCTURE**
    struct prodArticle:Decodable {
        var hits:hit
    }
    
    struct hit:Decodable{
        var hit:[editorials]
    }
    
    struct editorials:Decodable{
        var id:String
        var fields:field
    }
    
    struct field:Decodable{
        var status:String
        var author_name:String
        var titles:[String]
        var eye_catch_urls:[String]
        var body:String
    }
    //**PROD Article CODEABLE STRUCTURE**

    func getFromProdEndpoint(){
        guard let url = URL(string: authHeader.prodUrl.rawValue) else {return}
        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url as URL) {
            (data, response, error) in
            guard let data = data else {return}
            self.parseProdEndpoint(data: data)
            
            DispatchQueue.main.async {
                self.delegateProd?.articleContentList(articleContent: self.articleList)
            }
        }
        task.resume()
    }

    func parseProdEndpoint(data:Data){
        //serialize the data
        do{
            //decode and place article IDs in an Array
            let jsonDecoded = try JSONDecoder().decode(prodArticle.self, from: data)
            let hits = jsonDecoded.hits.hit
         
            for singleHit in hits {
                let status = singleHit.fields.status
                let author = singleHit.fields.author_name
                let titles = singleHit.fields.titles
                let images = singleHit.fields.eye_catch_urls
                let id = singleHit.id
                let body = singleHit.fields.body
                
                let tempArticle = ArticleModel(id: id, status: status, author: author, title: titles, body: body, images: images)
                
                self.articleList.append(tempArticle)
            }
        }catch let error {
            print("error: ", error)
        }
    }
    
    // MARK:  HELPER METHODS
    //Check member property: 'environment' for either dev/prod
    func configureEnvironmentURL() -> String?  {
        
        var url:String?
        
        if environment == env.prod.rawValue {
            url = authHeader.prodUrl.rawValue
            guard let url = url else {return nil}
            return url
        } else if environment == env.dev.rawValue{
            url = authHeader.devUrl.rawValue
            guard let url = url else {return nil}
            return url
        } else {
            print("Environment does not exists.")
            return nil
        }
    }
    
    // MARK: GET URL FOR ARTICLE INFORMATION FROM SERVER.
    //If an 'id' is present.  Use URL to get Article Content.
    //If no 'id' is present.  Use URL to get Article ID.
    //Get data from server
//    func getArticleFromServer(id:Int?, last:Bool?){
//        guard let url = configureEnvironmentURL() else {return}
//
//        let config = URLSessionConfiguration.default
//        config.httpAdditionalHeaders = [authHeader.authType.rawValue : authHeader.authString.rawValue]
//
//        let session = URLSession(configuration: config)
//
//        //If ID is present, we will want to fetch article content.  Else we are just fetching for articleIDs
//        if let id = id {
//            let address = "\(url)/\(id)"
//            guard let url = NSURL(string: address) else { return }
//            self.fetch(url: url, session: session, content:true, id:id, last:last)
//        } else {
//            guard let url = NSURL(string: url) else { return }
//            self.fetch(url: url, session: session, content: false, id: nil, last:nil)
//        }
//    }
    
    //If 'Content' is true.  Fetch Article Content.
    //If 'Content' is false.  Fetch Article ID.
//    private func fetch(url:NSURL, session:URLSession, content:Bool, id:Int?, last:Bool?){
//
//        let task = session.dataTask(with: url as URL) {
//            (data, response, error) in
//
//            //Check for successful server connection and data received.  Send to PARSE PROCESS.
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data {
//                if content {
//                    //print("content received.")
//                    guard let id = id else {return}
//                    self.parseJSONForArticleContent(data: responseData, id: id, last: nil)
//
//                    //delegate after last item.
//                    guard let last = last else {return}
//
//                    if last {
////                        self.delegate?.articleContentList(articleModelList: self.fetchedArticleContent, articleContentModelList: self.articleDict)
//                    }
//                } else {
//                    self.parseJSONForArticleID(data: responseData)
//                    self.fetchContentFromID()
//                }
//            } else {
//                print("Did not receive data.")
//            }
//        }
//        task.resume()
//    }
    
    //Parse for Article ID
//    func parseJSONForArticleID(data:Data){
//        //serialize the data
//        do{
//            //decode and place article IDs in an Array
//            let jsonDecoded = try JSONDecoder().decode(articles.self, from: data)
//
//            for article in jsonDecoded.articles {
//                articleIDs.append(article.article_id)
//            }
//        }catch{
//            print("unable to create json object.")
//        }
//    }
    
    //Fetch Article Content with ID
//    private func fetchContentFromID(){
//
//        for i in 0..<articleIDs.count {
//
//            if i != articleIDs.count - 1{
//                getArticleFromServer(id: articleIDs[i], last: nil)
//            } else {
//                getArticleFromServer(id: articleIDs[i], last: true)
//            }
//        }
//    }
    
    //Parse Article Content with IDs
//    func parseJSONForArticleContent(data:Data, id:Int, last:Bool?){
//        do{
//            //decode for article content
//            let jsonDecoded = try JSONDecoder().decode(articleContentList.self, from: data)
//
//            guard let articleItems = jsonDecoded.article_items else {return}
//            for article in articleItems{
//                let articleContent = ArticleContentModel(id:id , content: article.content, input:article.input_type)
//                fetchedArticleContent.append(articleContent)
//            }
//
//            //Add to dictionary to organize data
//            articleDict = [id:fetchedArticleContent]
//        }catch {
//            //print("unable to create json object. \n Error: (error)")
//        }
//    }
}
