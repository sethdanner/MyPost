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
    
    @IBAction func addPostButtonTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add New Post", message: nil, preferredStyle: .alert)
        
        var usernameTextField: UITextField?
        var messageTextField: UITextField?
        
        alertController.addTextField { (usernameField) in
            usernameField.placeholder = "Enter username..."
            usernameTextField = usernameField
        }
        
        alertController.addTextField { (messageField) in
            messageField.placeholder = "Start message here..."
            messageTextField = messageField
        }
        
        let postAction = UIAlertAction(title: "Post", style: .default) { (action) in
            
            guard let username = usernameTextField?.text, !username.isEmpty, let message = messageTextField?.text, !message.isEmpty else { self.presentErrorAlert() ; return }
            
            self.postController.addPost(username: username, text: message, completion: {
                self.reloadTableView()
            })
        }
        alertController.addAction(postAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func presentErrorAlert() {
        
        let alertController = UIAlertController(title: "Uh oh!", message: "You may be missing information or have network connectivity issues. Please try again.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postController.posts.count
    }
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)

        let post = postController.posts[indexPath.row]
        
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.username) - \(Date.init(timeIntervalSince1970: post.timestamp))"

        return cell
    }
}
