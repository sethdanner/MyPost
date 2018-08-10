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
    
    let baseURL = URL(string: "https://mypost-b2114.firebaseio.com/posts")!
    var posts: [Post] = []
    
    func fetchPosts(completion: @escaping() -> Void) {
        
        let url = baseURL.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let data = data {
                
                do {
                    let jsonDecoder = JSONDecoder()
//                    let postDictionary = try jsonDecoder.decode([String:Post].self, from: data)
//                    let posts: [Post] = postDictionary.compactMap({$0})
                    let postDictionary = try jsonDecoder.decode(Dictionary<String, Post>.self, from: data)
                    self.posts = Array(postDictionary.values)
                    completion()
                } catch let error {
                    print(error)
                    completion() ; return
                }
            }
        }
        dataTask.resume()
        print(url)
    }
    
    func addPost(username: String, text: String, completion: @escaping() -> Void) {
        
        let post = Post(username: username, text: text)
        let url = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(post)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let data = data {
                
                self.posts.append(post)
                completion()
            }
            if let error = error {
                print(error)
                completion() ; return
            }
        }
        task.resume()
    }
}
