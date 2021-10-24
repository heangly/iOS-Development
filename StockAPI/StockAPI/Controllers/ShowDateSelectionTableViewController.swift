//
//  ShowDateSelectionController.swift
//  StockAPI
//
//  Created by Heang Ly on 10/24/21.
//

import UIKit

class ShowDateSelectionTableViewController: UITableViewController {
    //MARK: - Properties
    private let reuseId = "ShowDateSelection"
    
    var timeSeriesMonthlyAdjusted: TimeseriesMonthlyAdjusted?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }
    
    //MARK: - Helpers
    private func configureMainUI(){
        configureTableView()
    }
    
    private func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
    }
    
    
    //MARK: - Actions
    

    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        return cell
    }
}
