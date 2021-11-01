//
//  RegisterViewController.swift
//  LetsMeet
//
//  Created by Heang Ly on 10/31/21.
//

//
//  LoginViewController.swift
//  LetsMeet
//
//  Created by Heang Ly on 10/31/21.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let uv = UIImageView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.image = UIImage(named: "loginBackground")
        return uv
    }()

    private let signUpLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(name: "Avenir Book", size: 40)
        lb.text = "Sign Up"
        lb.textAlignment = .center
        return lb
    }()

    private lazy var usernameTextField = generateTextField(placeHolder: "Username")
    private lazy var usernameStackView = generateTextFieldStackView(textfield: usernameTextField)

    private lazy var emailTextField = generateTextField(placeHolder: "Email")
    private lazy var emailStackView = generateTextFieldStackView(textfield: emailTextField)

    private lazy var cityTextField = generateTextField(placeHolder: "City")
    private lazy var cityStackView = generateTextFieldStackView(textfield: cityTextField)

    private let genderSegement: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Male", "Female"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .white.withAlphaComponent(0.2)
        sc.tintColor = .white.withAlphaComponent(0.5)
        return sc
    }()

    private lazy var dateOfBirthTextField = generateTextField(placeHolder: "Date of Birth")
    private lazy var dateOfBirthStackView = generateTextFieldStackView(textfield: dateOfBirthTextField)

    private lazy var passwordTextField = generateTextField(placeHolder: "Password")
    private lazy var passwordStackView = generateTextFieldStackView(textfield: passwordTextField)


    private lazy var confirmPasswordTextField = generateTextField(placeHolder: "Confirm Password")
    private lazy var confirmPasswordStackView = generateTextFieldStackView(textfield: confirmPasswordTextField)
    
    private let signUpBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "signUpBtn"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        return btn
    }()

    private lazy var containerStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            usernameStackView,
            emailStackView,
            cityStackView,
            genderSegement,
            dateOfBirthStackView,
            passwordStackView,
            confirmPasswordStackView,
            ])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 40
        return sv
    }()

    private lazy var alreadyHaveAccountStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [alreadyHaveAccount, loginButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        return sv
    }()

    private let alreadyHaveAccount: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Avenir Book", size: 20)
        lb.text = "Already an account?"
        lb.textColor = .white
        return lb
    }()

    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir Book", size: 20)
        btn.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return btn
    }()


    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    //MARK: - Helpers
    private func configureMainUI() {
        navigationController?.navigationBar.tintColor = .white
    }

    private func generateTextField(placeHolder: String) -> UITextField {
        let texfield = UITextField()
        texfield.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.2)])
        texfield.textColor = .white
        texfield.borderStyle = .none
        texfield.font = UIFont(name: "Avenir Book", size: 20)
        texfield.isSecureTextEntry = placeHolder.lowercased().contains("password") ? true : false
        return texfield
    }

    private func generateTextFieldStackView(textfield: UITextField) -> UIStackView {
        let whileLine = UIView()
        whileLine.backgroundColor = .white
        whileLine.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [textfield, whileLine])
        stackView.axis = .vertical
        stackView.spacing = 5

        NSLayoutConstraint.activate([
            whileLine.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            whileLine.heightAnchor.constraint(equalToConstant: 2),
            ])

        return stackView
    }

    //MARK: - Actions
    @objc private func loginButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }

    //MARK: - Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        [backgroundImageView, signUpLabel, containerStackView, signUpBtn, alreadyHaveAccountStackView].forEach {
            view.addSubview($0)
        }

        let layout = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            signUpLabel.topAnchor.constraint(equalTo: layout.topAnchor),
            signUpLabel.leftAnchor.constraint(equalTo: layout.leftAnchor),
            signUpLabel.rightAnchor.constraint(equalTo: layout.rightAnchor),

            containerStackView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
            containerStackView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            containerStackView.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),

            genderSegement.widthAnchor.constraint(equalToConstant: view.frame.width - 40),

            signUpBtn.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 30),
            signUpBtn.leftAnchor.constraint(equalTo: containerStackView.leftAnchor),
            signUpBtn.rightAnchor.constraint(equalTo: containerStackView.rightAnchor),
            signUpBtn.heightAnchor.constraint(equalToConstant: 60),

            alreadyHaveAccountStackView.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -10),
            alreadyHaveAccountStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }


}
