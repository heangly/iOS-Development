//
//  LoginView.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapLoginButton(_ loginView: LoginView)
    func didTapDontHaveAccountButton(_ loginView: LoginView)
}

class LoginView: UIView {
    //MARK: - Properties
    weak var delegate: LoginViewDelegate?

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()

    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let textFieldPlaceHolder = "Email"
        let view = Utilities().inputContainerView(withImage: image, withTextFieldPlaceholder: textFieldPlaceHolder)
        return view
    }()

    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let textFieldPlaceHolder = "Password"
        let view = Utilities().inputContainerView(withImage: image, withTextFieldPlaceholder: textFieldPlaceHolder, isSecureTextEntry: true)
        return view
    }()

    private lazy var loginButton: UIButton = {
        let btn = Utilities().authButton(title: "Log In")
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return btn
    }()

    private let stackView = Utilities().stackView()

    private let dontHaveAccountbutton: UIButton = {
        let btn = Utilities().attributeTextButton(firstPartTitle: "Don't have an account? ", secondPartTitle: "Sign Up")
        btn.addTarget(self, action: #selector(dontHaveAccountButtonTapped), for: .touchUpInside)
        return btn
    }()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllSubViews()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    func configureUI() {
        backgroundColor = .twitterBlue
    }

    //MARK: - Actions
    @objc func loginButtonTapped() {
        delegate?.didTapLoginButton(self)
    }

    @objc func dontHaveAccountButtonTapped() {
        delegate?.didTapDontHaveAccountButton(self)
    }

    //MARK: - AddSubviews
    func addAllSubViews() {
        let subStackViews = [emailContainerView, passwordContainerView, loginButton]
        subStackViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }

        let subViews = [logoImageView, stackView, dontHaveAccountbutton]
        subViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    //MARK: - Constraints
    override func layoutSubviews() {
        super.layoutSubviews()

        let layout = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: layout.topAnchor),

            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -40),

            emailContainerView.heightAnchor.constraint(equalToConstant: 50),

            passwordContainerView.heightAnchor.constraint(equalToConstant: 50),

            loginButton.heightAnchor.constraint(equalToConstant: 50),

            dontHaveAccountbutton.bottomAnchor.constraint(greaterThanOrEqualTo: layout.bottomAnchor, constant: -10),
            dontHaveAccountbutton.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
}

