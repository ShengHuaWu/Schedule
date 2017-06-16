//
//  AppDelegate.swift
//  Schedule
//
//  Created by ShengHua Wu on 10/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit
import Apollo

let graphQLEndpoint = "https://api.graph.cool/simple/v1/cj3rfuq2qvkuy01135ud5c2d6"
let apollo = ApolloClient(url: URL(string: graphQLEndpoint)!)

@UIApplicationMain

// MARK: - App Delegate
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Properties
    var window: UIWindow?
    private let router = Router()
    
    // MARK: Application Delegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let navigationController = window?.rootViewController as! UINavigationController
        let classListVC = navigationController.viewControllers.first as! ClassListViewController
        router.configure(classListVC, in: navigationController)
        
        return true
    }
}

// MARK: - Router
struct Router {
    func configure(_ classListViewController: ClassListViewController, in navigationController: UINavigationController) {
        classListViewController.title = "Classes"
        
        let viewModel = ClassListViewModel(apollo: apollo) { [weak viewController = classListViewController] (state) in
            viewController.flatMap { $0.updateUI(with: state) }
        }
        classListViewController.viewModel = viewModel
    }
}

