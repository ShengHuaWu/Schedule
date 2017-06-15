//
//  ClassListViewModel.swift
//  Schedule
//
//  Created by ShengHua Wu on 15/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

final class ClassListViewModel {
    // MARK: Properties
    private(set) var state: State<[ClassDetails]> = .normal([]) {
        didSet {
            callback(state)
        }
    }
    
    private let callback: (State<[ClassDetails]>) -> ()
    
    // MARK: Designated Initializer
    init(callback: @escaping (State<[ClassDetails]>) -> ()) {
        self.callback = callback
    }
}
