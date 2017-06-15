//
//  ClassListViewController.swift
//  Schedule
//
//  Created by ShengHua Wu on 13/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Class List View Controller
final class ClassListViewController: UITableViewController {
    // MARK: Propertiess
    fileprivate let cellIdentifier = "ClassCell"
    
    var viewModel: ClassListViewModel?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allClassesQuery = AllClassesQuery()
        apollo.fetch(query: allClassesQuery) { (result, error) in
            guard let classes = result?.data?.allClasses else { return }
            
            classes.forEach { print($0.fragments.classDetails) }
        }
    }
    
    // MARK: Public Methods
    func updateUI(with state: State<[ClassDetails]>) {
        tableView.reloadData()
    }
}

// MARK: - Table View Data Source
extension ClassListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.state.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "Class Title"
        cell.detailTextLabel?.text = "Teacher name / 10 students"
        return cell
    }
}
