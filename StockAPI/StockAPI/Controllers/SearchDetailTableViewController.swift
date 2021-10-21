//
//  SearchDetailTableViewController.swift
//  StockAPI
//
//  Created by Heang Ly on 10/20/21.
//

import UIKit

class SearchDetailTableViewController: UITableViewController {
    //MARK: - Properties

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    //MARK: - Helpers
    private func configureMainUI() {
        configureNavBar()
        configureTableView()
    }
    
    private func configureNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonDidTap))
    }

    private func configureTableView() {
        tableView.register(SearchDetailTableViewFirstCell.self, forCellReuseIdentifier: SearchDetailTableViewFirstCell.reuseableID)
        tableView.register(SearchDetailTableViewSecondCell.self, forCellReuseIdentifier: SearchDetailTableViewSecondCell.reuseableID)
        tableView.rowHeight = 260
        tableView.separatorStyle = .none
    }
    
    //MARK: - Actions
    @objc private func backButtonDidTap(){
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case [0, 0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailTableViewFirstCell.reuseableID, for: indexPath) as! SearchDetailTableViewFirstCell
            return cell
        case [0, 1]:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailTableViewSecondCell.reuseableID, for: indexPath) as! SearchDetailTableViewSecondCell
            return cell
        default:
            return UITableViewCell()
        }

    }


}
