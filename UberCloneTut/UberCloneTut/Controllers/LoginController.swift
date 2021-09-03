//
//  ViewController.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/1/21.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    //MARK: - Properties
    private let titleLabel = GenerateUI.forMainLabel()

    private let emailTextField = GenerateUI.forTextField(withPlaceHolder: "Email")

    private let passwordTextField = GenerateUI.forTextField(withPlaceHolder: "Password", isSecureText: true)

    private let loginButton: UIButton = {
        let btn = GenerateUI.forAuthMainButton(title: "Sign In")
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()

    private let dontHaveAccountButton: UIButton = {
        let btn = GenerateUI.forAuthNavigationBottomButton(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()


    private let stackViews = GenerateUI.forAuthStackViews()

    //MARK: - Actions
    @objc func handleShowSignUp() {
        let controller = SignupController()
        navigationController?.pushViewController(controller, animated: true)
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        addNotificationObservers()
    }


    //MARK: - Helpers
    func configureMainUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        addAllSubviews()
        addAllConstraints()
    }

    func addNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }

    @objc func inputDidChange() {
        if validateAllInputs() {
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

    @objc func handleLogin() {
        if validateAllInputs() {
            let email = emailTextField.text!
            let password = passwordTextField.text!

            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("DEBUG: Error login -> \(error.localizedDescription)")
                    return
                }
                print("DEBUG: Successfully Login...")
            }
        }
    }

    func validateAllInputs() -> Bool {
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty {
            return true
        }
        return false
    }
}

//MARK: - Add Subviews & Constraints
extension LoginController {
    func addAllSubviews() {
        let allSubviews = [titleLabel, stackViews, dontHaveAccountButton]
        allSubviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let emailContainer = GenerateUI.forInputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), withTexfield: emailTextField)
        let passwordContainer = GenerateUI.forInputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), withTexfield: passwordTextField)
        
        let subViewsInStackViews = [emailContainer, passwordContainer, loginButton]
        subViewsInStackViews.forEach {
            stackViews.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        stackViews.setCustomSpacing(50, after: passwordContainer)
    }

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
