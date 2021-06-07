//
//  HomeViewController.swift
//  MyJournalFullstack
//
//  Created by IDN MEDIA on 06/05/21.
//

import UIKit

protocol HomeViewDelegate {
    var presenter: HomePresenterDelegate? { get set }
    
    func reloadPostsData(data: [HomeModel])
}

class HomeViewController: UITableViewController, HomeViewDelegate {
    
    @IBOutlet weak var homeNavigationBar: UINavigationItem?
    
    
    var presenter: HomePresenterDelegate?
    var posts = [HomeModel]()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetchPosts()
        
        homeNavigationBar?.title = "Posts"
        homeNavigationBar?.rightBarButtonItem = .init(title: "Create Post", style: .plain, target: self, action: #selector(handleCreatePost))
    }
    
    @objc func handleCreatePost() {
        presenter?.handleCreatePost()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.presenter?.fetchPosts()
        }
    }
    
    func reloadPostsData(data: [HomeModel]) {
        self.posts = data
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Delete Post")
            let post = self.posts[indexPath.row]
            presenter?.deletePost(post: post)
                print("Successfully deleted post from server")
                self.posts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
