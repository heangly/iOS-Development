//
//  SearchViewController.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

private let cellReuseIdentifier = "UserCell"

class SearchViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI(){
        tableView.register(UserCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 64
//        tableView.separatorStyle = .none
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UserCell
        return cell
    }
}
