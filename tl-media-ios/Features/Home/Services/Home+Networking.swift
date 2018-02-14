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
    // delegate prop.
    var delegateProd:ArticleDelegate?
    var delegateElements:ArticleElementListDelegate?
    //var articleDict = [Int:[ArticleContentModel]]()  //mark for delete *2018/02/13
    var articleList = [ArticleModel]()
    var articleElementList = [ArticleDetailElementModel]()
    
    //Server endpoint
    enum authHeader:String{
        case authType = "Authorization"
        case authString = "Bearer 18ea0f254ce9bef70b6d95e10b03c6c36d9e4155c1fcc2322f69ab92c52069d2"
        case devUrl = "https://cms-api-dev.tabi-labo.com/api/v1/article"
        case prodUrl = "https://cms-api.tabi-labo.com/api/v1/article"
        case prodPostedUrl = "https://cms-api.tabi-labo.com/api/v1/article?status=posted"
        //case prodUrl = "https://search-tl-search-ah5hia2jqloge7xcptvricgete.ap-northeast-1.cloudsearch.amazonaws.com/2013-01-01/search?q=titles:1&q.parser=structured&sort=post_date%20desc&size=20"  //cloudSearch  //mark for delete *2018/02/13
    }
    
    enum env:String{
        case dev
        case prod
    }
    
    //SELECTED ENVIRONMENT
    var environment = env.prod.rawValue  // dev or prod
  
    // MARK: LIFECYCLE
    init(id:String?){
        //getArticleFromServer(id: nil, last:nil) //disabled during testing
        if let id = id {
            self.getFromProdEndpoint(id:id)
        } else {
            self.getFromProdEndpoint(id:nil)
        }
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
        var body:String
    }

    //**PROD Article CODEABLE STRUCTURE**
    func getFromProdEndpoint(id:String?){

        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [authHeader.authType.rawValue : authHeader.authString.rawValue]
        
        let session = URLSession(configuration: config)
        
        var address:String?
        var initialReq:Bool = true
        
        //if 'id' received, fetch article detail.
        if let id = id {
            address = "\(authHeader.prodUrl.rawValue)/\(id)"   //remove two options
            initialReq = false
        } else {
            address = "\(authHeader.prodPostedUrl.rawValue)"
            initialReq = true
        }
   
        guard let url = NSURL(string: address!) else { return }
        let task = session.dataTask(with: url as URL) {
            (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            do{
                //decode and place article IDs in an Array
                let json = try JSONSerialization.jsonObject(with: data!)
                print(json)
                
                if initialReq {
                    parseJsonData(json: json)
                    //put to main thread
                    DispatchQueue.main.async {
                        self.delegateProd?.articleContentList(articleContent: self.articleList)
                    }
                } else {
                    parseJsonForArticleDetails(json:json)
                    //put to main thread
                    DispatchQueue.main.async {
                        self.delegateElements?.getArticleElements(elements: self.articleElementList)
                    }
                }


            }catch let error {
                print("error: ", error)
            }
        }
        task.resume()
    
    enum articleNodes:String{
        case article_id
        case author_id
        case body
        case create_user_name
        case created_at
        case post_date
        case tags
        case titles
        case eye_catch_urls
        case images
    }
    
    func parseJsonData(json:Any){
        let jsonObject = json as! [String:AnyObject]
        let articleDetails = jsonObject["articles"]
        
        guard let articleDeets = articleDetails else {return}
        let articleArray = articleDeets as! [AnyObject]
        for article in articleArray {
            if article["status"] as! String ==  "posted" {
                let status = "posted"
                if let id = article[articleNodes.article_id.rawValue]   //,
                    //let authorId = article[articleNodes.author_id.rawValue]
                {
                    guard let id = id else {return}
                    guard let authorId = article[articleNodes.author_id.rawValue] else {return}
                    let author = article[articleNodes.create_user_name.rawValue] as! String
                    let title = article[articleNodes.titles.rawValue] as! [String]
                    let body = article[articleNodes.body.rawValue] as! String
                    let postDate = article[articleNodes.post_date.rawValue] as! String
                    let eyeCatchUrls = article[articleNodes.eye_catch_urls.rawValue] as! [String]
                    
                    let model = ArticleModel(id: "\(id)", status: status, author: author, title: title, body: body, postDate: postDate, authorId: "\(authorId)", images: eyeCatchUrls)
                    self.articleList.append(model)
                }
            }
        }
    }
        
        func parseJsonForArticleDetails(json:Any) {
       
            let jsonObject = json as! [String:AnyObject]
            let article = jsonObject["article_items"] as! [AnyObject]
            //let sectionCount = article.count
            var index = 0
            for elements in article{
                let inputType = elements["input_type"] as! String

                if let content = elements["content"] as? String {
                    let elementsModel = ArticleDetailElementModel(index: index, inputType: inputType, content: content)
                    articleElementList.append(elementsModel)
                    index += 1
                }else {
                    print("blah, not string object.")
                }
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

        /*  MARK FOR DELETE:  2018/02/13  TO REMOVE 2018/02/16
         TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
         TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
         TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
         */
        
        //    func getArticleFromServer(id:Int?, last:Bool?){
        //
        //        let config = URLSessionConfiguration.default
        //        config.httpAdditionalHeaders = [testauthHeader.testauthType.rawValue : testauthHeader.testauthString.rawValue]
        //
        //        let session = URLSession(configuration: config)
        //        guard let id = id else { return }
        //        let address = "\(testauthHeader.testurl.rawValue)"
        //        guard let url = NSURL(string: address) else { return }
        //        let task = session.dataTask(with: url as! URL) {
        //            (data, response, error) in
        //
        //            //print(data)
        //            let httpResponse = response as? HTTPURLResponse
        //            //print(httpResponse?.statusCode)
        //
        //            do{
        //                //decode and place article IDs in an Array
        //                let json = try JSONSerialization.jsonObject(with: data!)
        //                //print(json)
        //            }catch let error {
        //                print("error: ", error)
        //            }
        //        }
        //         task.resume()
        //    }
        
        //    private func fetch(url:NSURL, session:URLSession, content:Bool, id:Int?, last:Bool?){
        //        print(url)
        //        let task = session.dataTask(with: url as URL) {
        //            (data, response, error) in
        //
        //            print(data)
        //            let httpResponse = response as? HTTPURLResponse
        //            print(httpResponse?.statusCode)
        //
        //            //Check for successful server connection and data received.  Send to parse data
        //            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data {
        //                self.TESTparseProdEndpoint(data: responseData)
        //            }
        //
        //        }
        //        task.resume()
        //    }
        
        //    func TESTparseProdEndpoint(data:Data){
        //        do{
        //            //decode and place article IDs in an Array
        //
        //            let json = try JSONSerialization.jsonObject(with: data)
        //            print(json)
        //            parseOldWay(json: json)
        //
        //            //NEW WAY
        //            //            let jsonDecoded = try JSONDecoder().decode(prodArticle.self, from: data)
        //            //            //print(jsonDecoded.hits.hit[0].fields)
        //
        //        }catch let error {
        //            print("error: ", error)
        //        }
        //    }
        
        
        /*
         END TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
         TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
         TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST
         */
        
        //enum testauthHeader:String{
        //    case testauthType = "Authorization"
        //    case testauthString = "Bearer 18ea0f254ce9bef70b6d95e10b03c6c36d9e4155c1fcc2322f69ab92c52069d2"
        //    case testurl = "https://cms-api.tabi-labo.com/api/v1/article"
        //    //case testurl = "https://cms-api-dev.tabi-labo.com/api/v1/article"
        //    case testprodUrl = "https://search-tl-search-dev-bvb77sqhuziebbdvilw5qem5uy.ap-northeast-1.cloudsearch.amazonaws.co"
        //}
        
        // ***MARK FOR DELETE*** 2018/02/13
        //        guard let url = URL(string: authHeader.prodUrl.rawValue) else {return}
        //        let config = URLSessionConfiguration.default
        //
        //        let session = URLSession(configuration: config)
        //
        //        let task = session.dataTask(with: url as URL) {
        //            (data, response, error) in
        //            guard let data = data else {return}
        //            self.parseProdEndpoint(data: data)
        //            DispatchQueue.main.async {
        //                self.delegateProd?.articleContentList(articleContent: self.articleList)
        //            }
        //        }
        //        task.resume()
        // ***MARK FOR DELETE***
    }
    
    
    // ***MARK FOR DELETE*** 2018/02/13
    //    func parseProdEndpoint(data:Data){
    //        //serialize the data
    //       print(data)
    //        do{
    //            //decode and place article IDs in an Array
    //            let jsonDecoded = try JSONDecoder().decode(prodArticle.self, from: data)
    //            print(jsonDecoded)
    //            let hits = jsonDecoded.hit.hits
    //
    //            for singleHit in hits {
    //                let status = singleHit.fields.status
    //                let author = singleHit.fields.author_name
    //                let titles = singleHit.fields.titles
    //                let images = singleHit.fields.eye_catch_urls
    //                let id = singleHit.id
    //                let body = singleHit.fields.body
    //
    //                let tempArticle = ArticleModel(id: id, status: status, author: author, title: titles, body: body, images: images)
    //
    //                self.articleList.append(tempArticle)
    //            }
    //        }catch let error {
    //            print("error: ", error)
    //        }
    //    }
    // ***MARK FOR DELETE***
    
    // ***MARK FOR DELETE*** 2018/02/13
    //
    //        let hit = hits["hit"] as! [AnyObject]
    //
    //
    //
    //
    //
    //        for entry in hit {
    //            let fields = entry["fields"] as! [String:AnyObject]
    //
    //            let status = fields["status"] as! String
    //                if status == "posted" {
    //                    //capture id, status, author, body
    //                    let id = fields["id"] as! String
    //                    let author = fields["author_name"] as! String
    //                    let body = fields["body"] as! String
    //                    let postDate = fields["post_date"] as! String
    //
    //                    //capture arrays of title, images
    //                    let eyeCatchImageURL = fields["eye_catch_urls"] as! [String]
    //                    let titles = fields["titles"] as! [String]
    //
    //                    let article = ArticleModel(id: id, status: status, author: author, title: titles, body: body, images: eyeCatchImageURL, postDate: postDate)
    //
    //                    articleList.append(article)
    //                }
    //            }
    //        print(articleList.count)
    
    //    func parseProdEndpoint(data:Data){
    //        do{
    //            //decode and place article IDs in an Array
    //            let json = try JSONSerialization.jsonObject(with: data)
    //            parseJsonData(json: json)
    //        }catch let error {
    //            print("error: ", error)
    //        }
    //    }
    
    // ***MARK FOR DELETE***
}

