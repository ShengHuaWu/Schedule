//
//  State.swift
//  Schedule
//
//  Created by ShengHua Wu on 15/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import Foundation

enum State<T> {
    case normal(T)
    case empty
    case error(Error)
}

extension State where T: RangeReplaceableCollection {
    var count: T.IndexDistance {
        switch self {
        case let .normal(elements): return elements.count
        default: return 0
        }
    }
    
    func element(at index: T.Index) -> T.Iterator.Element? {
        switch self {
        case let .normal(elements): return elements[index]
        default: return nil
        }
    }
}
