//
//  ClassDetailsViewModel.swift
//  Schedule
//
//  Created by ShengHua Wu on 17/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import Apollo

final class ClassDetailsViewModel {
    // MARK: Properties
    private(set) var state: State<ClassDetails> = .empty {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (State<ClassDetails>) -> ()
    private let apollo: ApolloClient
    
    // MARK: Designated Initializer
    init(apollo: ApolloClient, callback: @escaping (State<ClassDetails>) -> ()) {
        self.apollo = apollo
        self.callback = callback
    }
    
    // MARK: Public Methods
}
