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
    private(set) var state: State<ClassDetailsWithStudents> = .empty {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (State<ClassDetailsWithStudents>) -> ()
    private let apollo: ApolloClient
    private let classID: GraphQLID
    
    // MARK: Designated Initializer
    init(apollo: ApolloClient, classID: GraphQLID, callback: @escaping (State<ClassDetailsWithStudents>) -> ()) {
        self.apollo = apollo
        self.classID = classID
        self.callback = callback
    }
    
    // MARK: Public Methods
    func fetchClassDetails() {
        state = .loading
        
        let classDetailsQuery = ClassDetailsQuery(classId: classID)
        apollo.fetch(query: classDetailsQuery) { (result, error) in
            guard let classDetailsWithStudents = result?.data?.class?.fragments.classDetailsWithStudents else { return }
            print(classDetailsWithStudents)
            
            self.state = .normal(classDetailsWithStudents)
        }
    }
}
