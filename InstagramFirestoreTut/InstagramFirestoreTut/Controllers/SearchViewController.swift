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
    private var filteredUsers = [User]()
    private var searchController = UISearchController(searchResultsController: nil)
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
        fetchAllUsers()
    }

    //MARK: - Helpers
    func configureUI() {
        tableView.register(UserCell.self, forCellReuseIdentifier: userCellReusableIdentifier)
        tableView.rowHeight = 64
    }

    func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = false
        searchController.searchResultsUpdater = self
    }

    //MARK: - API
    func fetchAllUsers() {
        UserService.fetchAllUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }

}

//MARK: - UITableViewDatasource
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellReusableIdentifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}

//MARK: - UITableView Delegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.otherUserProfileId = inSearchMode ? filteredUsers[indexPath.row].uid : users[indexPath.row].uid
        navigationController?.pushViewController(vc, animated: true)
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
