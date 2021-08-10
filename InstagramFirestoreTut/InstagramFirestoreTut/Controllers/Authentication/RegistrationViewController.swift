//
//  RegistrationViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/9/21.
//

import UIKit

class RegisterationViewController: UIViewController {
    //MARK: - Properties
    private let plusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.setDimensions(height: 140, width: 140)
        return btn
    }()

    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    
    private let usernameTextField = CustomTextField(placeholder: "Username")
    
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setHeight(50)
        btn.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstPart: "Already have an account? ", secondPart: "Log In")
        btn.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return btn
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Actions
    @objc func handleShowLogIn(){
        navigationController?.popViewController(animated: true)
    }

    //MARK: - Helper
    func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        view.addSubview(plusButton)
        plusButton.centerX(inView: view)
        plusButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signUpButton])
        view.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 20
        stack.anchor(top: plusButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
