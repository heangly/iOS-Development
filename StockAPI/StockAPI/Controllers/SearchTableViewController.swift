//
//  ViewController.swift
//  StockAPI
//
//  Created by Heang Ly on 10/17/21.
//

import UIKit
import Combine

class SearchTableViewController: UITableViewController {
    //MARK: - Properties
    private let apiService = APIService()
    private var subscriber = Set<AnyCancellable>()

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter a company name or symbol"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        performSearch()
    }

    //MARK: - Helpers
    private func configureMainUI() {
        configureNavigationBar()
        configureTableView()
    }

    private func configureNavigationBar() {
        navigationItem.searchController = searchController
    }

    private func configureTableView() {
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseID)
    }

    //MARK: - Actions
    private func performSearch() {
        apiService.fetchSymbolsPublisher(keywords: "S&P500").sink { completion in
            switch completion {
            case.failure(let error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { searchResults in
            print(searchResults)
        }.store(in: &subscriber)

    }
}


//MARK: - UISearch Delegate
extension SearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
}


//MARK: - UITableViewDelegate
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseID, for: indexPath) as! SearchTableViewCell
        return cell

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
