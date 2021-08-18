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
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)

    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
        fetchUsers()
    }

    //MARK: - Helpers
    func configureUI() {
        tableView.register(UserCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 64
//        tableView.separatorStyle = .none
    }

    func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = false
        searchController.searchResultsUpdater = self
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
        return inSearchMode ? filteredUsers.count : users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}


// UITableViewDelegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let otherUserID = inSearchMode ? filteredUsers[indexPath.row].uid : users[indexPath.row].uid
        controller.otherUserProfileID = otherUserID
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UISearchResultUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter {
            $0.username.contains(searchText)
                || $0.fullname.lowercased().contains(searchText)
        }
        self.tableView.reloadData()
    }
}
