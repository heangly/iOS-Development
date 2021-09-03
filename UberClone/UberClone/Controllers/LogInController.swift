//
//  ViewController.swift
//  UberClone
//
//  Created by Heang Ly on 9/1/21.
//

import UIKit
import Firebase

class LogInController: UIViewController {
    //MARK: - Properties
    private let titleLabel = UILabel().uberLabel()

    private let emailTextField = UITextField().textField(withPlaceHolder: "Email")

    private let passwordTextField = UITextField().textField(withPlaceHolder: "Password", isSecureText: true)

    private let loginButton: UIButton = {
        let btn = UIButton().authMainButton(title: "Sign In")
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()

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
        addNotificationObservers()
    }

    //MARK: - Actions
    @objc func handleShowSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc func handleLogin() {
        if validateAllInput(){
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("Error login \(error.localizedDescription)")
                    return
                }
                
                print("Successfully login")
            }
        }
    }

    //MARK: - Helpers
    func addNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }

    @objc func inputDidChange() {
        if validateAllInput() {
            loginButton.isUserInteractionEnabled = true
            loginButton.isEnabled = true
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.backgroundColor = .mainBlueTint
        } else {
            loginButton.isUserInteractionEnabled = false
            loginButton.isEnabled = false
            loginButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
            loginButton.backgroundColor = UIColor.mainBlueTint.withAlphaComponent(0.8)
        }
    }

    func validateAllInput() -> Bool {
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty {
            return true
        }

        return false
    }

    func configureMainUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        addAllSubviews()
        addAllConstraints()
    }


    func addAllSubviews() {
        let allSubviews = [titleLabel, stackViews, dontHaveAccountButton]
        allSubviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let emailContainerView = UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), withTexfield: emailTextField)
        let passwordContainerView = UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), withTexfield: passwordTextField)

        let subViewsInStackViews = [emailContainerView, passwordContainerView, loginButton]
        subViewsInStackViews.forEach {
            stackViews.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }

        stackViews.setCustomSpacing(50, after: passwordContainerView)
    }

    //MARK: - Constraints
    func addAllConstraints() {
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

