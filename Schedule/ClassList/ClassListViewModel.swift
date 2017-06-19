//
//  ClassListViewModel.swift
//  Schedule
//
//  Created by ShengHua Wu on 15/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation
import Apollo

final class ClassListViewModel {
    // MARK: Properties
    private(set) var state: State<[ClassDetails]> = .normal([]) {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (State<[ClassDetails]>) -> ()
    private let apollo: ApolloClient
    
    // MARK: Designated Initializer
    init(apollo: ApolloClient, callback: @escaping (State<[ClassDetails]>) -> ()) {
        self.apollo = apollo
        self.callback = callback        
    }
    
    // MARK: Public Methods
    func fetchClasses() {
        state = .loading
        
        let allClassesQuery = AllClassesQuery()
        apollo.fetch(query: allClassesQuery) { (result, error) in
            guard let classes = result?.data?.allClasses else { return }
            
            let classDetails = classes.map { $0.fragments.classDetails }
            self.state = .normal(classDetails)            
        }
    }
}
