//
//  Post.swift
//  MyPost
//
//  Created by Seth Danner on 8/7/18.
//  Copyright © 2018 Seth Danner. All rights reserved.
//

import Foundation

struct PostJSONDictionary:Codable {
    
    let posts: [Post]
}

struct Post: Codable {
    
    let username: String
    let text: String
    let timestamp: TimeInterval
    
    init(username: String, text: String, timestamp: TimeInterval = Date().timeIntervalSince1970) {
        
        self.username = username
        self.text = text
        self.timestamp = timestamp
    }
}
