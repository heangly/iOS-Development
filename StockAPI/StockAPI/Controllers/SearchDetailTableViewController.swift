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
        configureTableView()
    }

    private func configureTableView() {
        tableView.register(SearchDetailTableViewFirstCell.self, forCellReuseIdentifier: SearchDetailTableViewFirstCell.reuseableID)
        tableView.rowHeight = 220
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
            return UITableViewCell()
        default:
            return UITableViewCell()
        }

    }


}
