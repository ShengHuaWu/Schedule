//
//  ClassCell.swift
//  Schedule
//
//  Created by ShengHua Wu on 18/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

class ClassCell: UITableViewCell {
    // MARK: Properties
    var classDetails: ClassDetails! {
        didSet {
            textLabel?.text = classDetails.title
            let name = classDetails.teacher?.fragments.teacherDetails.name ?? ""
            let count = classDetails.studentsMeta.count
            detailTextLabel?.text = "teacher: \(name). \(count) students."
        }
    }
}
