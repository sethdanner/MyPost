//
//  PostController.swift
//  MyPost
//
//  Created by Seth Danner on 8/7/18.
//  Copyright © 2018 Seth Danner. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PostController {
    
    let baseURL = URL(string: "https://mypost-b2114.firebaseio.com/")!
    var posts: [Post] = []
    
    func fetchPosts(completion: @escaping (Bool) -> Void) {
        
        let url = baseURL.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let data = data {
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let postDictionary = try jsonDecoder.decode(PostJSONDictionary.self, from: data)
                    let posts = postDictionary.posts.compactMap({$0})
                    self.posts = posts
                    completion(true)
                } catch let error {
                    print(error)
                    completion(false) ; return
                }
            }
        }
        dataTask.resume()
        print(url)
    }
    
    func uploadPost(username: String, text: String, timestamp: TimeInterval, completion: @escaping (Bool) -> Void) {
        
        let post = Post(username: username, text: text)
        let url = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(post)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let data = data {
                
                self.posts.append(post)
                completion(true)
            }
            if let error = error {
                print(error)
                completion(false) ; return
            }
        }
        task.resume()
    }
}
