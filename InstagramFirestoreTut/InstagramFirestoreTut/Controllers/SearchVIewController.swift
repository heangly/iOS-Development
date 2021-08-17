//
//  SearchVIewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

private let userCellReusableIdentifier = "UserCell"

class SearchViewController: UITableViewController {
    //MARK: - Properties
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchAllUsers()
    }
    
    //MARK: - Helpers
    func configureUI(){
        tableView.register(UserCell.self, forCellReuseIdentifier: userCellReusableIdentifier)
        tableView.rowHeight = 64
    }
    
    //MARK: - API
    func fetchAllUsers(){
        UserService.fetchAllUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDatasource
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellReusableIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}
