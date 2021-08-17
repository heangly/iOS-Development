//
//  SearchViewController.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

private let cellReuseIdentifier = "UserCell"

class SearchViewController: UITableViewController {
    //MARK: - Properties
    private var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }

    //MARK: - Helpers
    func configureUI() {
        tableView.register(UserCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 64
//        tableView.separatorStyle = .none
    }

    //MARK: - API
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}
