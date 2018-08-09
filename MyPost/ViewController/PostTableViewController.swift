//
//  PostTableViewController.swift
//  MyPost
//
//  Created by Seth Danner on 8/9/18.
//  Copyright © 2018 Seth Danner. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    let postController = PostController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postController.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)

        

        return cell
    }
}
