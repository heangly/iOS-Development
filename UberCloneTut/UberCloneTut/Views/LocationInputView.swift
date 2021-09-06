//
//  LocationInputView.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/5/21.
//

import UIKit

protocol LocationInputViewDelegate: class {
    func dimissLocationInputView()
}

class LocationInputView: UIView {
    //MARK: - Properties
    weak var delegate: LocationInputViewDelegate?

    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp-1").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Heang Ly"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let startLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 6 / 2
        return view
    }()

    private let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private let destinationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private lazy var startingLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current Location"
        tf.backgroundColor = .systemGroupedBackground
        tf.font = UIFont.systemFont(ofSize: 14)
        addLeftPadding(toTextField: tf, withHeight: 30, withWidth: 8)
        return tf
    }()

    private lazy var destinationLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a destination"
        tf.backgroundColor = UIColor.darkGray.withAlphaComponent(0.1)
        tf.returnKeyType = .search
        tf.font = UIFont.systemFont(ofSize: 14)
        addLeftPadding(toTextField: tf, withHeight: 30, withWidth: 8)
        return tf
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureMainUI()
        addAllSubViews()
        addAllConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - Actions
    @objc func handleBackTapped() {
        delegate?.dimissLocationInputView()
    }

    //MARK: - Helpers
    func configureMainUI() {
        backgroundColor = .white
        addShadow()
    }

    func addLeftPadding(toTextField textField: UITextField, withHeight height: CGFloat, withWidth width: CGFloat) {
        let padding = UIView()
        padding.translatesAutoresizingMaskIntoConstraints = false
        padding.heightAnchor.constraint(equalToConstant: height).isActive = true
        padding.widthAnchor.constraint(equalToConstant: width).isActive = true

        textField.leftView = padding
        textField.leftViewMode = .always
    }

    func addAllSubViews() {
        let subviews = [backButton, titleLabel, startLocationIndicatorView, linkingView, destinationIndicatorView, startingLocationTextField, destinationLocationTextField]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func addAllConstraints() {
        let constraints = [
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            startingLocationTextField.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            startingLocationTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            startingLocationTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            startingLocationTextField.heightAnchor.constraint(equalToConstant: 30),

            destinationLocationTextField.topAnchor.constraint(equalTo: startingLocationTextField.bottomAnchor, constant: 18),
            destinationLocationTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            destinationLocationTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            destinationLocationTextField.heightAnchor.constraint(equalToConstant: 30),

            startLocationIndicatorView.centerYAnchor.constraint(equalTo: startingLocationTextField.centerYAnchor),
            startLocationIndicatorView.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
            startLocationIndicatorView.widthAnchor.constraint(equalToConstant: 6),
            startLocationIndicatorView.heightAnchor.constraint(equalToConstant: 6),

            destinationIndicatorView.centerYAnchor.constraint(equalTo: destinationLocationTextField.centerYAnchor),
            destinationIndicatorView.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
            destinationIndicatorView.widthAnchor.constraint(equalToConstant: 6),
            destinationIndicatorView.heightAnchor.constraint(equalToConstant: 6),

            linkingView.centerXAnchor.constraint(equalTo: startLocationIndicatorView.centerXAnchor),
            linkingView.topAnchor.constraint(equalTo: startLocationIndicatorView.bottomAnchor, constant: 5),
            linkingView.bottomAnchor.constraint(equalTo: destinationIndicatorView.topAnchor, constant: -5),
            linkingView.widthAnchor.constraint(equalToConstant: 1),
        ]

        NSLayoutConstraint.activate(constraints)
    }

}
