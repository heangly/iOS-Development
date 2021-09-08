//
//  RegistrationController.swift
//  UberClone
//
//  Created by Heang Ly on 9/2/21.
//

import UIKit
import Firebase
import GeoFire

class SignUpController: UIViewController {
    //MARK: - Properties
    private var location = LocationHandler.shared.locationManager.location

    private let titleLabel = UILabel().uberLabel()

    private let emailTextField = UITextField().textField(withPlaceHolder: "Email")

    private let fullNameTextField = UITextField().textField(withPlaceHolder: "Fulll Name")

    private let passwordTextField = UITextField().textField(withPlaceHolder: "Password", isSecureText: true)

    private let accountTypeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Rider", "Driver"])
        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        sc.layer.borderWidth = 1
        sc.layer.borderColor = UIColor.lightGray.cgColor
        sc.selectedSegmentIndex = 0
        return sc
    }()

    private let signUpButton: UIButton = {
        let btn = UIButton().authMainButton(title: "Sign Up")
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()

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
        addNotificationObservers()
    }

    //MARK: - Actions
    @objc func handleShowSignIn() {
        navigationController?.popViewController(animated: true)
    }

    func addNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }

    func validateInputFields() -> Bool {
        if let email = emailTextField.text,
            let fullName = fullNameTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty, !fullName.isEmpty, !password.isEmpty {
            return true
        }

        return false
    }

    @objc func inputDidChange() {
        if validateInputFields() {
            signUpButton.isUserInteractionEnabled = true
            signUpButton.isEnabled = true
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.backgroundColor = .mainBlueTint
        } else {
            signUpButton.isUserInteractionEnabled = false
            signUpButton.isEnabled = false
            signUpButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
            signUpButton.backgroundColor = UIColor.mainBlueTint.withAlphaComponent(0.8)
        }
    }

    @objc func handleSignUp() {
        if validateInputFields() {
            let email = emailTextField.text!
            let fullname = fullNameTextField.text!
            let password = passwordTextField.text!
            let accountTypeIndex = accountTypeSegmentedControl.selectedSegmentIndex

            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print("Failed to register user with error \(error)")
                    return
                }

                guard let uid = result?.user.uid else { return }


                let values: [String: Any] = [
                    "email": email,
                    "fullname": fullname,
                    "accountTypeIndex": accountTypeIndex
                ]

                if accountTypeIndex == 1 {
                    guard let location = self.location else { return }
                    let geofire = GeoFire(firebaseRef: REF_DRIVER_LOCATIONS)
                    geofire.setLocation(location, forKey: uid) { error in
                        self.uploadUserDataAndShowHomeController(uid: uid, values: values)
                    }
                } else {
                    self.uploadUserDataAndShowHomeController(uid: uid, values: values)
                }


            }
        }

    }

    //MARK: - Helpers
    func uploadUserDataAndShowHomeController(uid: String, values: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(values) { error, ref in
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: HomeController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }

    func configureMainUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        addAllSubViews()
        addAllConstraints()
    }

    func addAllSubViews() {
        let allSubViews = [titleLabel, stackViews, alreadyHaveAccountButton]
        allSubViews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let emailContainerView = UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), withTexfield: emailTextField)
        let fullnameContainerView = UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), withTexfield: fullNameTextField)
        let passwordContainerView = UIView().inputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), withTexfield: passwordTextField)
        let accountTypeContainerView = UIView().accountTypeFieldContainerView(withImage: #imageLiteral(resourceName: "ic_account_box_white_2x"), segmentedControl: accountTypeSegmentedControl)

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
