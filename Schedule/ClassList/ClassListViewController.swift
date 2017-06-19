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
    
    var viewModel: ClassListViewModel!
    
    var presentClassDetails: ((ClassDetails) -> ())?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.backgroundColor = .white
        refreshControl?.addTarget(self, action: #selector(refershAction(sender:)), for: .valueChanged)
        
        viewModel.fetchClasses()
    }
    
    // MARK: Public Methods
    func updateUI(with state: State<[ClassDetails]>) {
        switch state {
        case .loading:
            refreshControl?.beginRefreshing()
        case .normal:
            tableView.reloadData()
            refreshControl?.endRefreshing()
        default:
            refreshControl?.endRefreshing()
        }
    }
    
    // MARK: Actions
    func refershAction(sender: UIRefreshControl) {
        viewModel.fetchClasses()
    }
}

// MARK: - Table View Data Source
extension ClassListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel == nil ? 0 : viewModel.state.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ClassCell
        viewModel.state.element(at: indexPath.row).flatMap { cell.classDetails = $0 }
        return cell
    }
}

extension ClassListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.state.element(at: indexPath.row).flatMap { presentClassDetails?($0) }
    }
}
