//
//  LoginViewController.swift
//  LetsMeet
//
//  Created by Heang Ly on 10/31/21.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {
    //MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let uv = UIImageView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.image = UIImage(named: "loginBackground")
        return uv
    }()

    private let loginLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(name: "Avenir Book", size: 40)
        lb.text = "Login"
        lb.textAlignment = .center
        return lb
    }()

    private lazy var emailStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailWhiteLine])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        return sv
    }()

    private let emailWhiteLine: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = .white
        return uv
    }()

    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont(name: "Avenir Book", size: 20)
        lb.text = "Email"
        return lb
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.2)])
        tf.textColor = .white
        tf.borderStyle = .none
        tf.font = UIFont(name: "Avenir Book", size: 20)
        return tf
    }()

    private lazy var passwordStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField, passwordWhiteLine])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        return sv
    }()

    private let passwordWhiteLine: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = .white
        return uv
    }()

    private let passwordLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont(name: "Avenir Book", size: 20)
        lb.text = "Password"
        return lb
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.2)])
        tf.textColor = .white
        tf.borderStyle = .line
        tf.font = UIFont(name: "Avenir Book", size: 20)
        tf.borderStyle = .none
        return tf
    }()

    private let forgetPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forget Password?", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir Book", size: 20)
        btn.addTarget(self, action: #selector(forgetPasswordBtnDidTap), for: .touchUpInside)
        return btn
    }()

    private lazy var emailPasswordStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, forgetPasswordBtn])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 40
        return sv
    }()

    private let loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "signInBtn"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.addTarget(self, action: #selector(loginBtnDidTap), for: .touchUpInside)
        return btn
    }()

    private lazy var dontHaveAccountStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [dontHaveAccountLabel, signUpButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        return sv
    }()

    private let dontHaveAccountLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Avenir Book", size: 20)
        lb.text = "Don't have an account?"
        lb.textColor = .white
        return lb
    }()

    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign up", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir Book", size: 20)
        btn.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
        return btn
    }()


    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    //MARK: - Helpers
    private func configureMainUI() {
        view.backgroundColor = .blue
    }

    //MARK: - Actions
    @objc private func signUpButtonDidTap() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func forgetPasswordBtnDidTap() {
        if let email = emailTextField.text, !email.isEmpty {

        } else {
            ProgressHUD.showError("Please insert your email")
        }
    }

    @objc private func loginBtnDidTap() {
        if let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty {

        } else {
            ProgressHUD.showError("All fields are required")
       
        }
    }

    //MARK: - Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        [backgroundImageView, loginLabel, emailPasswordStackView, loginBtn, dontHaveAccountStackView].forEach {
            view.addSubview($0)
        }

        let layout = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loginLabel.topAnchor.constraint(equalTo: layout.topAnchor),
            loginLabel.leftAnchor.constraint(equalTo: layout.leftAnchor),
            loginLabel.rightAnchor.constraint(equalTo: layout.rightAnchor),

            emailPasswordStackView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30),
            emailPasswordStackView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            emailPasswordStackView.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),

            emailWhiteLine.leftAnchor.constraint(equalTo: emailPasswordStackView.leftAnchor),
            emailWhiteLine.rightAnchor.constraint(equalTo: emailPasswordStackView.rightAnchor),
            emailWhiteLine.heightAnchor.constraint(equalToConstant: 2),

            passwordWhiteLine.leftAnchor.constraint(equalTo: emailPasswordStackView.leftAnchor),
            passwordWhiteLine.rightAnchor.constraint(equalTo: emailPasswordStackView.rightAnchor),
            passwordWhiteLine.heightAnchor.constraint(equalToConstant: 2),

            loginBtn.topAnchor.constraint(equalTo: emailPasswordStackView.bottomAnchor, constant: 40),
            loginBtn.leftAnchor.constraint(equalTo: emailPasswordStackView.leftAnchor),
            loginBtn.rightAnchor.constraint(equalTo: emailPasswordStackView.rightAnchor),
            loginBtn.heightAnchor.constraint(equalToConstant: 60),

            dontHaveAccountStackView.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20),
            dontHaveAccountStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
    }


}
