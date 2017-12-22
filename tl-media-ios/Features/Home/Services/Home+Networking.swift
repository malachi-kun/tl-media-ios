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
    var delegateProd:ArticleDelegate?

    var articleDict = [Int:[ArticleContentModel]](), articleList = [ArticleModel]()
    

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
        self.getFromProdEndpoint()
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
                //print(singleHit)
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
}
