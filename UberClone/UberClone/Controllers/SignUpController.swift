//
//  RegistrationController.swift
//  UberClone
//
//  Created by Heang Ly on 9/2/21.
//

import UIKit

class SignUpController: UIViewController {
    //MARK: - Properties
    private let titleLabel = UILabel().uberLabel()

    private let emailContainerView: UIView = {
        let textField = UITextField().textField(withPlaceHolder: "Email")
        return UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), withTexfield: textField)
    }()

    private let fullnameContainerView: UIView = {
        let textField = UITextField().textField(withPlaceHolder: "Fulll Name")
        return UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_account_box_white_2x"), withTexfield: textField)
    }()

    private let passwordContainerView: UIView = {
        let textField = UITextField().textField(withPlaceHolder: "Password", isSecureText: true)
        return UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), withTexfield: textField)
    }()

    private let accountTypeContainerView: UIView = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        sc.layer.borderWidth = 1
        sc.layer.borderColor = UIColor.lightGray.cgColor
        sc.selectedSegmentIndex = 0
        return UIView().accountTypeContainerView(withImage: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: sc)
    }()


    private let signUpButton = UIButton().authMainButton(title: "Sign Up")

    private let alreadyHaveAccountButton: UIButton = {
        let btn = UIButton().authNavigationBottomButton(firstPart: "Already have an account? ", secondPart: "Sign in")
        btn.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return btn
    }()

    private let stackViews = UIStackView().authStackViews()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    //MARK: - Actions
    @objc func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }

    //MARK: - Helpers
    func configureMainUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }

    func addSubViews() {
        let allSubViews = [titleLabel, stackViews, alreadyHaveAccountButton]
        allSubViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let subViewsInStackViews = [emailContainerView, fullnameContainerView, passwordContainerView, signUpButton]
        subViewsInStackViews.forEach {
            stackViews.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        stackViews.distribution = .fill
        stackViews.insertArrangedSubview(accountTypeContainerView, at: 3)
        accountTypeContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        stackViews.setCustomSpacing(50, after: accountTypeContainerView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addSubViews()

        let layout = view.safeAreaLayoutGuide

        let customConstraints = [
            titleLabel.topAnchor.constraint(equalTo: layout.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            stackViews.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            stackViews.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -32),
            stackViews.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 32),

            alreadyHaveAccountButton.topAnchor.constraint(greaterThanOrEqualTo: stackViews.bottomAnchor, constant: 10),
            alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -10),
            alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
        ]

        NSLayoutConstraint.activate(customConstraints)
    }
}
