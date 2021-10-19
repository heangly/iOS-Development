//
//  ViewController.swift
//  StockAPI
//
//  Created by Heang Ly on 10/17/21.
//

import UIKit
import Combine
import MBProgressHUD

class SearchTableViewController: UITableViewController, UIAnimatable {
    //MARK: - Properties
    private enum Mode {
        case onboarding
        case search
    }

    private let apiService = APIService()
    private var subscriber = Set<AnyCancellable>()
    private var searchResults: SearchResults?
    @Published private var mode: Mode = .onboarding
    @Published private var searchQuery = String()


    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter a company name or symbol"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()

    private lazy var searchPlaceHolderStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchPlaceHolderImage, searchPlaceHolderLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()

    private let searchPlaceHolderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imDca")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let searchPlaceHolderLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Search for companies to calculate potential returns via dollar cost averaging."
        lb.font = UIFont(name: "AvenirNext-Medium", size: 18)!
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        observeForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    //MARK: - Helpers
    private func configureMainUI() {
        configureNavigationBar()
        configureTableView()
    }

    private func configureNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTableView() {
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseID)
    }

    //MARK: - Actions
    private func performSearch(searchQuery: String) {
        showLoadingAnimation()
        apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { completion in
            switch completion {
            case.failure(let error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { [weak self] results in
            self?.searchResults = results
            self?.tableView.reloadData()
            self?.hideLoadingAnimation()
        }.store(in: &subscriber)
    }

    private func observeForm() {
        $searchQuery
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main, options: nil)
            .sink { [weak self] keyword in
            guard !keyword.isEmpty else { return }
            self?.performSearch(searchQuery: keyword)
        }.store(in: &subscriber)

        $mode.sink { [weak self] mode in
            switch mode {
            case .onboarding:
                self?.configureSearchPlaceHolderStackView()
            case .search:
                self?.searchPlaceHolderStackView.removeFromSuperview()
            }
        }.store(in: &subscriber)
    }

    //MARK: - Subviews & Constraints
    private func configureSearchPlaceHolderStackView() {
        view.addSubview(searchPlaceHolderStackView)

        NSLayoutConstraint.activate([
            searchPlaceHolderStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            searchPlaceHolderStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            searchPlaceHolderStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            searchPlaceHolderStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}


//MARK: - UISearch Delegate
extension SearchTableViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else { return }
        self.searchQuery = searchQuery
    }
}


//MARK: - UITableViewDelegate
extension SearchTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = searchResults?.items else { return 0 }
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseID, for: indexPath) as! SearchTableViewCell
        guard let items = searchResults?.items else { return cell }
        cell.configure(with: items[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        self.searchResults = nil
        self.tableView.reloadData()
        mode = .onboarding
    }
}
