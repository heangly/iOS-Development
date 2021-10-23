//
//  SearchDetailTableViewCell.swift
//  StockAPI
//
//  Created by Heang Ly on 10/20/21.
//

import UIKit

class SearchDetailTableViewFirstCell: UITableViewCell {
    //MARK: - Propereties
    static let reuseableID = "SearchDetailTableViewCell"

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstHStackView, currentValueTitleLabel, currentValueLabel, investmentStackView, gainStackView, annualReturnStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    //MARK: -  firstHStackView
    private lazy var firstHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstHStackLeftLabel, firstHStackRightLabel])
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let firstHStackLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 24)!
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.text = "SPY"
        return label
    }()

    private let firstHStackRightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 22)!
        label.textColor = .lightGray
        label.text = "S&P 500 ETF"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    //MARK: - Title
    private let currentValueTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)!
        label.text = "Current Value (USD)"
        return label
    }()

    //MARK: - Value
    private let currentValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)!
        label.text = "5000"
        return label
    }()

    //MARK: - investmentStackView
    private lazy var investmentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [investmentLabel, investmentValueLabel])
        stackView.distribution = .fill
        return stackView
    }()

    private let investmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)!
        label.text = "Investment amount"
        return label
    }()

    private let investmentValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)!
        label.text = "USD 100"
        return label
    }()

    //MARK: - gainStackView
    private lazy var gainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [gainLabel, gainValueStackView])
        stackView.distribution = .fill
        return stackView
    }()

    private let gainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)!
        label.text = "Gain"
        return label
    }()

    private lazy var gainValueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [gainValueLeftLabel, gainValueRightLabel])
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let gainValueLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)!
        label.text = "+100.25"
        return label
    }()

    private let gainValueRightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)!
        label.textColor = .green
        label.text = "(+10.25%)"
        return label
    }()


    //MARK: - annualReturnStackView
    private lazy var annualReturnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [annualLabel, annualValueLabel])
        stackView.distribution = .fill
        return stackView
    }()

    private let annualLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)!
        label.text = "Annual return"
        return label
    }()

    private let annualValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)!
        label.textColor = .green
        label.text = "10.5%"
        return label
    }()


    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        addSubViewsAndConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    private func configureUI() {
        selectionStyle = .none
    }


    //MARK: - Actions
    func configureAssetInCell(asset: Asset?) {
        guard let asset = asset else { return }
        firstHStackRightLabel.text = asset.searchResult.name
        firstHStackLeftLabel.text = asset.searchResult.symbol
    }

    //MARK: - SubViews & Constraints
    private func addSubViewsAndConstraints() {
        addSubview(vStackView)

        NSLayoutConstraint.activate([
            vStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            vStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            vStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }

}

