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
    
    static func start() -> UIViewController
}

class HomeRouter: HomeRouterDelegate {
    
    static func start() -> UIViewController {
        let router = HomeRouter()
        
        let view = HomeViewController()
        let presenter = HomePresenter()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        
        return view
    }
    
    
}
