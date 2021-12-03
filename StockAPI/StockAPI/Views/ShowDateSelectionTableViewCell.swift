//
//  ShowDateSelectionTableViewCell.swift
//  StockAPI
//
//  Created by Heang Ly on 10/26/21.
//

import UIKit

class ShowDateSelectionTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let reuseableId = "ShowDateSelectionTableViewCell"

    private let monthLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "AvenirNext-Medium", size: 20)!
        lb.text = "December 2020"
        return lb
    }()

    private let monthsAgoLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "AvenirNext-Medium", size: 16)!
        lb.text = "Recent"
        lb.textColor = .darkGray
        return lb
    }()

    private lazy var stackViews: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [monthLabel, monthsAgoLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMainUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    private func configureMainUI() {
        configureSubViewsAndConstraints()
    }

    public func configure(with monthInfo: MonthInfo, index: Int, isSelected: Bool) {
        monthLabel.text = monthInfo.date.MMYYFormat
        if index == 1 {
            monthsAgoLabel.text = "1 month ago"
        } else if index > 1 {
            monthsAgoLabel.text = "\(index) months ago"
        } else {
            monthsAgoLabel.text = "Just invested"
        }
        accessoryType = isSelected ? .checkmark : .none
    }


    //MARK: - Actions

    private func configureSubViewsAndConstraints() {
        contentView.addSubview(stackViews)
        NSLayoutConstraint.activate([
            stackViews.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            stackViews.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            stackViews.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViews.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }

}
