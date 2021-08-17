//
//  SearchVIewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

private let userCellReusableIdentifier = "UserCell"

class SearchViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI(){
        tableView.register(UserCell.self, forCellReuseIdentifier: userCellReusableIdentifier)
        tableView.rowHeight = 64
    }
}

//MARK: - UITableViewDatasource
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellReusableIdentifier, for: indexPath)
        return cell
    }
}
