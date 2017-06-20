//
//  StudentCell.swift
//  Schedule
//
//  Created by ShengHua Wu on 20/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class StudentCell: UITableViewCell {
    // MARK: Properties
    var student: StudentDetails! {
        didSet {
            textLabel?.text = student.name
        }
    }
}
