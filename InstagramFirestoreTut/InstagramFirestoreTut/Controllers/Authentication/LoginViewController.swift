//
//  LoginViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/9/21.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.keyboardType = .emailAddress
        tf.setHeight(50)
        tf.attributedPlaceholder = NSAttributedString(string: "email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.layer.cornerRadius = 5
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1)
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.keyboardType = .emailAddress
        tf.setHeight(50)
        tf.attributedPlaceholder = NSAttributedString(string: "email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        return tf
    }()

    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.setHeight(50)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return btn
    }()
    

    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: "Get help signing in.", attributes: boldAtts))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAtts))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helper
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame

        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)

        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)

    }
}
