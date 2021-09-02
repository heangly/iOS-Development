//
//  ViewController.swift
//  UberClone
//
//  Created by Heang Ly on 9/1/21.
//

import UIKit

class LogInController: UIViewController {
    //MARK: - Properties
    private let titleLabel = UILabel().uberLabel()
    
    private let emailContainerView: UIView = {
        let textField = UITextField().textField(withPlaceHolder: "Email")
        return UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), withTexfield: textField)
    }()

    private let passwordContainerView: UIView = {
        let textField = UITextField().textField(withPlaceHolder: "Password", isSecureText: true)
        return UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), withTexfield: textField)
    }()

    private let loginButton = UIButton().authMainButton(title: "Sign In")
    
    private let dontHaveAccountButton: UIButton = {
        let btn = UIButton().authNavigationBottomButton(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()

    private let stackViews = UIStackView().authStackViews()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }
    
    //MARK: - Actions
    @objc func handleShowSignUp(){
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }

    //MARK: - Helpers
    func configureMainUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func addSubviews() {
        let allSubviews = [titleLabel, stackViews, dontHaveAccountButton]
        allSubviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let subViewsInStackViews = [emailContainerView, passwordContainerView, loginButton]
        subViewsInStackViews.forEach {
            stackViews.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }

        stackViews.setCustomSpacing(50, after: passwordContainerView)
    }

    //MARK: - Constraints
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        addSubviews()

        let layout = view.safeAreaLayoutGuide

        let customContraints = [
            titleLabel.topAnchor.constraint(equalTo: layout.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            stackViews.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            stackViews.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -32),
            stackViews.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 32),

            dontHaveAccountButton.topAnchor.constraint(greaterThanOrEqualTo: stackViews.bottomAnchor, constant: 10),
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -10),
            dontHaveAccountButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
        ]

        NSLayoutConstraint.activate(customContraints)
    }

}

