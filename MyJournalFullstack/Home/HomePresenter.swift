//
//  HomePresenter.swift
//  MyJournalFullstack
//
//  Created by IDN MEDIA on 06/05/21.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: AnyObject {
    var router: HomeRouterDelegate? { get set }
    var view: HomeViewDelegate? { get set }
    
    func fetchPosts()
    func handleCreatePost()
}

class HomePresenter: HomePresenterDelegate {
    var router: HomeRouterDelegate?
    var view: HomeViewDelegate?
    
    
    func fetchPosts() {
        AppServices.shared.fetchPosts { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts: ", err)
            case .success(let posts):
                self.view?.reloadPostsData(data: posts)
            }
            
        }
    }
    
    func handleCreatePost() {
        AppServices.shared.createPost(title: "iOS Title", body: "iOS Body") { err in
            if let err = err {
                print("failed to create post object", err)
                return
            }
            
            print("Finished creating post")
        }
    }
    
}
