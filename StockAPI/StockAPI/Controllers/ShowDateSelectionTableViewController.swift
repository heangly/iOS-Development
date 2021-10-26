//
//  ShowDateSelectionController.swift
//  StockAPI
//
//  Created by Heang Ly on 10/24/21.
//

import UIKit

class ShowDateSelectionTableViewController: UITableViewController {
    //MARK: - Properties
    var timeSeriesMonthlyAdjusted: TimeseriesMonthlyAdjusted?
    private var monthInfos: [MonthInfo] = []
    var didSelectDate: ((Int) -> Void)?


    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        setupMonthInfos()
    }

    //MARK: - Helpers
    private func configureMainUI() {
        title = "Select Date"
        configureTableView()
    }

    private func configureTableView() {
        tableView.register(ShowDateSelectionTableViewCell.self, forCellReuseIdentifier: ShowDateSelectionTableViewCell.reuseableId)
    }

    private func setupMonthInfos() {
        if let monthInfos = timeSeriesMonthlyAdjusted?.getMonthInfos() {
            self.monthInfos = monthInfos
        }
    }


    //MARK: - Actions
}

//MARK: - TableView Delegate
extension ShowDateSelectionTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthInfos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowDateSelectionTableViewCell.reuseableId, for: indexPath) as! ShowDateSelectionTableViewCell
        let monthInfo = monthInfos[indexPath.item]
        let index = indexPath.row
        cell.configure(with: monthInfo, index: index)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectDate?(indexPath.item)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
