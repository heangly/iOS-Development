//
//  SearchDetailTableViewController.swift
//  StockAPI
//
//  Created by Heang Ly on 10/20/21.
//

import UIKit
import Combine

class SearchDetailTableViewController: UITableViewController {
    //MARK: - Properties
    var asset: Asset?
    @Published private var initialDateOfInvestmentIdx: Int?
    private let showDateSelectionTableViewController = ShowDateSelectionTableViewController()
    private var subscriber = Set<AnyCancellable>()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        observeForm()
    }

    //MARK: - Helpers
    private func configureMainUI() {
        navigationItem.largeTitleDisplayMode = .never
        configureTableView()
    }

    private func configureTableView() {
        tableView.register(SearchDetailTableViewFirstCell.self, forCellReuseIdentifier: SearchDetailTableViewFirstCell.reuseableID)
        tableView.register(SearchDetailTableViewSecondCell.self, forCellReuseIdentifier: SearchDetailTableViewSecondCell.reuseableID)
        tableView.rowHeight = 260
        tableView.separatorStyle = .none
    }

    private func observeForm() {
        $initialDateOfInvestmentIdx.sink { [weak self] index in
            print(index)
        }.store(in: &subscriber)
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case [0, 0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailTableViewFirstCell.reuseableID, for: indexPath) as! SearchDetailTableViewFirstCell
            cell.configureAssetInCell(asset: asset)
            return cell
        case [0, 1]:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchDetailTableViewSecondCell.reuseableID, for: indexPath) as! SearchDetailTableViewSecondCell
            cell.delegate = self

            if let maxValueForSlider = asset?.timeSeriesMonthlyAdjusted.getMonthInfos().count {
                cell.configureSlider(maxValue: maxValueForSlider.floatValue)
            }

            showDateSelectionTableViewController.didSelectDate = { [weak self] index in
                self?.handleDateSelection(at: index, cell: cell)
            }
            return cell
        default:
            return UITableViewCell()
        }

    }
}

extension SearchDetailTableViewController: SearchDetailTableViewSecondCellDelegate {
    func moveIntialInvestmentTextFieldToShowDateSelection() {
        showDateSelectionTableViewController.selectedIdx = initialDateOfInvestmentIdx
        showDateSelectionTableViewController.timeSeriesMonthlyAdjusted = asset?.timeSeriesMonthlyAdjusted
        navigationController?.pushViewController(showDateSelectionTableViewController, animated: true)
    }

    func initialDateOfInvestmentDidChange(index: Int) {
        self.initialDateOfInvestmentIdx = index
    }

    private func handleDateSelection(at index: Int, cell: SearchDetailTableViewSecondCell) {
        guard navigationController?.visibleViewController is ShowDateSelectionTableViewController else { return }
        navigationController?.popViewController(animated: true)

        if let monthInfos = asset?.timeSeriesMonthlyAdjusted.getMonthInfos() {
            initialDateOfInvestmentIdx = index
            let monthInfo = monthInfos[index]
            let dateString = monthInfo.date.MMYYFormat
            cell.configureInitialDateInvestment(dateString: dateString)
        }
    }
}
