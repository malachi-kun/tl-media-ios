//
//  NetworkManager.swift
//  tl-media-ios
//
//  Created by Malachi Hul on 2017/11/28.
//  Copyright © 2017 Tabi-Labo. All rights reserved.
//

import UIKit
import Foundation

class NetworkManager {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Topic]?, String) -> ()
    
    var topic: [Topic] = []
    var errorMessage = ""
    
    // TODO
    let defaultSession = URLSession(configuration: .default)
    var dataTask:URLSessionDataTask?
    
 
    func getSearchResults() {
        // TODO
        // 1
        dataTask?.cancel()  //for new user, cancel if already exists.
        // 2
        if var urlComponents = URLComponents(string: "https://cms-api-dev.tabi-labo.com/api/v1/article/282211") {

        //if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            //urlComponents.query = "media=music&entity=song&term=\(searchTerm)"
            // 3
            guard let url = urlComponents.url else { return }
            
            //getRequest.addValue("Token xxxxxxxx", forHTTPHeaderField: "Authorization")
            // 4
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil  }
                // 5
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    print("data found: \(data)")
                    //self.updateSearchResults(data)
                    // 6
                    DispatchQueue.main.async {
                        //completion(self.topic, self.errorMessage)
                    }
                } else if let data = data,
                    let response = response as? HTTPURLResponse{
                    print("status code: \(response.statusCode)")
                }
        
            }
            dataTask?.resume()
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        topic.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        var index = 0
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let previewURLString = trackDictionary["previewUrl"] as? String,
                let previewURL = URL(string: previewURLString),
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String {
                topic.append(Topic(name: name, artist: artist, previewURL: previewURL, index: index))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
    
    func testConnection(){
        let config = URLSessionConfiguration.default
        let authString = "Bearer 18ea0f254ce9bef70b6d95e10b03c6c36d9e4155c1fcc2322f69ab92c52069d2"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config)
        
        let url = NSURL(string: "https://cms-api-dev.tabi-labo.com/api/v1/article/282211")
        let task = session.dataTask(with: url! as URL) {
            ( data, response, error) in
            if (response as? HTTPURLResponse) != nil {
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(dataString!)
            }
        }
        task.resume()
    }
    
}
