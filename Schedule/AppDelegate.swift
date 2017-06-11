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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

