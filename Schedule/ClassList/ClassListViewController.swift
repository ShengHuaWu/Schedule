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
    
    var viewModel: ClassListViewModel! {
        didSet {
            viewModel.fetchClasses()
        }
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    // MARK: Public Methods
    func updateUI(with state: State<[ClassDetails]>) {
        tableView.reloadData()
    }
}

// MARK: - Table View Data Source
extension ClassListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel == nil ? 0 : viewModel.state.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "Class Title"
        cell.detailTextLabel?.text = "Teacher name / 10 students"
        return cell
    }
}
