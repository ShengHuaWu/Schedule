//
//  ClassDetialsViewController.swift
//  Schedule
//
//  Created by ShengHua Wu on 13/06/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit

// MARK: - Class Details View Controller
final class ClassDetailsViewController: UITableViewController {
    // MARK: Properties
    fileprivate let cellIdentifier = "StudentCell"
    @IBOutlet weak var teacherView: TeacherView!
    
    var viewModel: ClassDetailsViewModel!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.backgroundColor = .white
        refreshControl?.addTarget(self, action: #selector(refreshAction(sender:)), for: .valueChanged)
        
        viewModel.fetchClassDetails()
    }
    
    // MARK: Public Methods
    func updateUI(with state: State<ClassDetailsWithStudents>) {
        switch state {
        case .loading:
            refreshControl?.beginRefreshing()
        case .normal:
            refreshControl?.endRefreshing()
            tableView.reloadData()
            
            teacherView.teacher = viewModel.state.teacher
        default:
            refreshControl?.endRefreshing()
        }
    }
    
    // MARK: Actions
    func refreshAction(sender: UIRefreshControl) {
        viewModel.fetchClassDetails()
    }
}


// MARK: - Table View Data Source
extension ClassDetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.students?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StudentCell
        cell.student = viewModel.state.students?[indexPath.row]
        return cell
    }
}
