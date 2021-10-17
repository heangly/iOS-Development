//
//  SearchTableViewCell.swift
//  StockAPI
//
//  Created by Heang Ly on 10/17/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let reuseID = "SearchTableViewCell"

    private let horizontalStackContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()

    private let leftVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()

    private let assetSymbolLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.text = "BA"
        return lb
    }()

    private let assetTypeLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .gray
        lb.text = "USD"
        return lb
    }()

    private let rightVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private let assetNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "The Boeing Company"
        lb.textAlignment = .right
        return lb
    }()

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMainUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureMainUI() {
        configureSubViewsAndContraints()
    }

    //MARK: - AddSubViews & Constraints
    private func configureSubViewsAndContraints() {
        addSubview(horizontalStackContainer)

        horizontalStackContainer.addArrangedSubview(leftVerticalStack)
        horizontalStackContainer.addArrangedSubview(rightVerticalStack)

        leftVerticalStack.addArrangedSubview(assetSymbolLabel)
        leftVerticalStack.addArrangedSubview(assetTypeLabel)

        rightVerticalStack.addArrangedSubview(assetNameLabel)


        NSLayoutConstraint.activate([
            horizontalStackContainer.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            horizontalStackContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            horizontalStackContainer.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 30),
            horizontalStackContainer.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -30)
           
            ])
    }

}
