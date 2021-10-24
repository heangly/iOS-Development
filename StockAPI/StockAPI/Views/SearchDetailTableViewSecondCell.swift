//
//  SearchDetailTableViewSecondCell.swift
//  StockAPI
//
//  Created by Heang Ly on 10/20/21.
//

import Foundation
import UIKit

protocol SearchDetailTableViewSecondCellDelegate: AnyObject {
    func moveIntialInvestmentTextFieldToShowDateSelection()
}

class SearchDetailTableViewSecondCell: UITableViewCell {
    //MARK: - Properties
    static let reuseableID = "SearchDetailTableViewSecondCell"
    
    weak var delegate: SearchDetailTableViewSecondCellDelegate?

    private let initialInvestmentAmountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your initial investment amount"
        tf.font = UIFont(name: "AvenirNext-Medium", size: 22)!
        tf.textColor = .lightGray
        tf.adjustsFontSizeToFitWidth = true
        tf.keyboardType = .numberPad
        tf.addDoneButton()
        tf.textColor = .black
        return tf
    }()

    private let initialInvestmentAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "Initial investment amount (USD)"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)!
        return label
    }()

    private let monthlyDollarCostTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Monthly dollar cost averaging amount"
        tf.font = UIFont(name: "AvenirNext-Medium", size: 22)!
        tf.textColor = .lightGray
        tf.adjustsFontSizeToFitWidth = true
        tf.keyboardType = .numberPad
        tf.textColor = .black
        tf.addDoneButton()
        return tf
    }()

    private let monthlyDollarCostLabel: UILabel = {
        let label = UILabel()
        label.text = "Monthly dollar cost averaging amount (USD)"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)!
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let initialDateInvestmentTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter the initial date of investment"
        tf.font = UIFont(name: "AvenirNext-Medium", size: 22)!
        tf.textColor = .lightGray
        tf.adjustsFontSizeToFitWidth = true
        tf.textColor = .black
        return tf
    }()

    private let initialDateInvestmentLabel: UILabel = {
        let label = UILabel()
        label.text = "initial date of investment (USD)"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)!
        return label
    }()

    private let slider: UISlider = {
        let slider = UISlider()
        slider.setValue(0.5, animated: true)
        slider.addTarget(self, action: #selector(sliderDidChangeValue), for: .valueChanged)
        return slider
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            initialInvestmentAmountTextField,
            initialInvestmentAmountLabel,
            monthlyDollarCostTextField,
            monthlyDollarCostLabel,
            initialDateInvestmentTextField,
            initialDateInvestmentLabel,
            slider
            ])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.setCustomSpacing(10, after: initialInvestmentAmountLabel)
        stackView.setCustomSpacing(10, after: monthlyDollarCostLabel)
        stackView.setCustomSpacing(20, after: initialDateInvestmentLabel)
        return stackView
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
        selectionStyle = .none
        initialDateInvestmentTextField.delegate = self
        addSubViewsAndConstraints()
    }
    
    //MARK: - Actions
    @objc private func sliderDidChangeValue(sender: UISlider!) {
    }

    @objc private func doneButtonDidTap() {
        print("done")
    }


    //MARK: - AddSubviews and Constraints
    private func addSubViewsAndConstraints() {
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }

}

extension SearchDetailTableViewSecondCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == initialDateInvestmentTextField {
            delegate?.moveIntialInvestmentTextFieldToShowDateSelection()
        }
        return false
    }
}
