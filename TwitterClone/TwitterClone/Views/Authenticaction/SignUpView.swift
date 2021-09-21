//
//  SignUpView.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

protocol SignUpViewDelegte: AnyObject {
    func didTapPlusPhotoButtonTapped(_ signUpView: SignUpView)
    func didTapAlreadyHaveAccountButton(_ signUpView: SignUpView)
    func didTapSignUpButton(_ signUpView: SignUpView, inputTextFieldValues: [String: String], profileImage: UIImage)
}

class SignUpView: UIView {
    //MARK: - Properties
    weak var delegate: SignUpViewDelegte?

    private var profileImage: UIImage?

    let plusPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(plusPhotoButtonTapped), for: .touchUpInside)
        return btn
    }()

    private let emailTextField = UITextField()

    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let textFieldPlaceHolder = "Email"
        let view = Utilities().inputContainerView(withImage: image, withTextField: emailTextField, withTextFieldPlaceholder: textFieldPlaceHolder)
        return view
    }()


    private let passwordTextField = UITextField()

    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let textFieldPlaceHolder = "Password"
        let view = Utilities().inputContainerView(withImage: image, withTextField: passwordTextField, withTextFieldPlaceholder: textFieldPlaceHolder, isSecureTextEntry: true)
        return view
    }()

    private let fullnameTextField = UITextField()

    private lazy var fullnameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let textFieldPlaceHolder = "Full Name"
        let view = Utilities().inputContainerView(withImage: image, withTextField: fullnameTextField, withTextFieldPlaceholder: textFieldPlaceHolder)
        return view
    }()

    private let usernameTextField = UITextField()

    private lazy var usernameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let textFieldPlaceHolder = "Username"
        let view = Utilities().inputContainerView(withImage: image, withTextField: usernameTextField, withTextFieldPlaceholder: textFieldPlaceHolder)
        return view
    }()

    private lazy var signUpButton: UIButton = {
        let btn = Utilities().authButton(title: "Sign Up")
        btn.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return btn
    }()

    private let stackView = Utilities().stackView()

    private let alreadyHaveAccountButton: UIButton = {
        let btn = Utilities().attributeTextButton(firstPartTitle: "Already have an account? ", secondPartTitle: "Log In")
        btn.addTarget(self, action: #selector(alreadyHaveAccountButtonTapped), for: .touchUpInside)
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
    @objc func signUpButtonTapped() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let profileImage = profileImage else { return }

        let inputTextFieldValues = [
            "email": email,
            "password": password,
            "fullname": fullname,
            "username": username
        ]

        delegate?.didTapSignUpButton(self, inputTextFieldValues: inputTextFieldValues, profileImage: profileImage)
    }

    @objc func alreadyHaveAccountButtonTapped() {
        delegate?.didTapAlreadyHaveAccountButton(self)
    }

    @objc func plusPhotoButtonTapped() {
        delegate?.didTapPlusPhotoButtonTapped(self)
    }

    func configurePlusPhotoImage(setImage image: UIImage) {
        plusPhotoButton.setImage(image, for: .normal)
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true

        profileImage = image
    }

    //MARK: - AddSubviews
    func addAllSubViews() {
        let subStackViews = [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, signUpButton]
        subStackViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }

        let subViews = [plusPhotoButton, stackView, alreadyHaveAccountButton]
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
            plusPhotoButton.heightAnchor.constraint(equalToConstant: 128),
            plusPhotoButton.widthAnchor.constraint(equalToConstant: 128),
            plusPhotoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusPhotoButton.topAnchor.constraint(equalTo: layout.topAnchor, constant: 10),

            stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -40),

            emailContainerView.heightAnchor.constraint(equalToConstant: 50),

            passwordContainerView.heightAnchor.constraint(equalToConstant: 50),

            signUpButton.heightAnchor.constraint(equalToConstant: 50),

            alreadyHaveAccountButton.bottomAnchor.constraint(greaterThanOrEqualTo: layout.bottomAnchor, constant: -10),
            alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
}
