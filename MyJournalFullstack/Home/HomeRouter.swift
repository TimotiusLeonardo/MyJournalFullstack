//
//  HomeRouter.swift
//  MyJournalFullstack
//
//  Created by IDN MEDIA on 06/05/21.
//

import Foundation
import UIKit

typealias HomeEntryPoint = HomeViewController

protocol HomeRouterDelegate {
    var entry: HomeEntryPoint? { get }
    
    static func start() -> HomeRouterDelegate
}

class HomeRouter: HomeRouterDelegate {
    var entry: HomeEntryPoint?
    
    static func start() -> HomeRouterDelegate {
        let router = HomeRouter()
        
        let view = HomeViewController()
        let presenter = HomePresenter()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        
        router.entry = view as HomeEntryPoint
        
        return router
    }
    
    
}
