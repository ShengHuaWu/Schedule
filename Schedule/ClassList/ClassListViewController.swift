//
//  ClassListViewController.swift
//  Schedule
//
//  Created by ShengHua Wu on 13/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

final class ClassListViewController: UITableViewController {
    // MARK: Propertiess
    fileprivate let cellIdentifier = "ClassCell"
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allClassesQuery = AllClassesQuery()
        apollo.fetch(query: allClassesQuery) { (result, error) in
            guard let classes = result?.data?.allClasses else { return }
            
            classes.forEach { print($0.fragments.classDetails) }
        }
    }
}

// MARK: - Table View Data Source
extension ClassListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
}
