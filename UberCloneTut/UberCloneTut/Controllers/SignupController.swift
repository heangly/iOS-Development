//
//  SignupController.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/2/21.
//

import UIKit
import Firebase

class SignupController: UIViewController {
    //MARK: - Properties
    private let titleLabel = GenerateUI.forMainLabel()

    private let emailTextField = GenerateUI.forTextField(withPlaceHolder: "Email")

    private let fullnameTextField = GenerateUI.forTextField(withPlaceHolder: "Full Name")

    private let passwordTextField = GenerateUI.forTextField(withPlaceHolder: "Password", isSecureText: true)

    private let accountTypeSegmentedControl: UISegmentedControl = {
        let ac = UISegmentedControl(items: ["Rider", "Driver"])
        ac.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        ac.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        ac.layer.borderWidth = 1
        ac.layer.borderColor = UIColor.lightGray.cgColor
        ac.selectedSegmentIndex = 0
        return ac
    }()

    private let signUpButton: UIButton = {
        let btn = GenerateUI.forAuthMainButton(title: "Sign Up")
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()

    private let alreadyHaveAccountButton: UIButton = {
        let btn = GenerateUI.forAuthNavigationBottomButton(firstPart: "Already have an account? ", secondPart: "Sign in")
        btn.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return btn
    }()

    private let stackViews = GenerateUI.forAuthStackViews()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        addNotificationObservers()
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
        addAllSubViews()
        addAllConstraints()
    }

    func validateInputFields() -> Bool {
        if let email = emailTextField.text,
            let fullname = fullnameTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !fullname.isEmpty,
            !password.isEmpty {
            return true
        }
        return false
    }

    @objc func handleSignUp() {
        if validateInputFields() {
            let email = emailTextField.text!
            let fullname = fullnameTextField.text!
            let password = passwordTextField.text!
            let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex

            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("DEBUG: Fail to register -> \(error.localizedDescription)")
                    return
                }

                guard let uid = result?.user.uid else { return }
                
                let values:[String: Any] = [
                    "email": email,
                    "fulllname": fullname,
                    "accountTypeIndex": accountTypeIndex
                ]
                
                Database.database().reference().child("users").child(uid).updateChildValues(values) { error, ref in
                    print("DEBUG: Successfully registered user and saved data...")
                }
            }

        }
    }

    @objc func handleTextFieldDidChange() {
        if validateInputFields() {
            signUpButton.isUserInteractionEnabled = true
            signUpButton.isEnabled = true
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.backgroundColor = UIColor.mainBlueTint
        } else {
            signUpButton.isUserInteractionEnabled = false
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
            signUpButton.backgroundColor = UIColor.mainBlueTint.withAlphaComponent(0.8)
        }
    }

    func addNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(handleTextFieldDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(handleTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldDidChange), for: .editingChanged)
    }

    func addAllSubViews() {
        let allSubViews = [titleLabel, stackViews, alreadyHaveAccountButton]
        allSubViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let emailContainerView = GenerateUI.forInputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), withTexfield: emailTextField)
        let fullnameContainerView = GenerateUI.forInputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), withTexfield: fullnameTextField)
        let passwordContainerView = GenerateUI.forInputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), withTexfield: passwordTextField)

        let subViewsInStackViews = [emailContainerView, fullnameContainerView, passwordContainerView, signUpButton]
        subViewsInStackViews.forEach {
            stackViews.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }

        let accountTypeContainerView = GenerateUI.forAccountTypeContainerView(withImage: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: accountTypeSegmentedControl)

        stackViews.distribution = .fill
        stackViews.insertArrangedSubview(accountTypeContainerView, at: 3)
        accountTypeContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        stackViews.setCustomSpacing(50, after: accountTypeContainerView)
    }

    func addAllConstraints() {
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
