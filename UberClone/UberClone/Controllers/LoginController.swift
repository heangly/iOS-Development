//
//  ViewController.swift
//  UberClone
//
//  Created by Heang Ly on 9/1/21.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "uber".uppercased()
        lb.font = UIFont(name: "Avenir-Light", size: 36)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()


    private let emailContainerView: UIView = {
        let ev = UIView()
        return ev
    }()

    private let emailImage: UIImageView = {
        let ei = UIImageView()
        ei.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        ei.tintColor = .white
        return ei
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField()
        let attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.white])
        tf.attributedPlaceholder = attributedPlaceholder
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.keyboardAppearance = .dark
        tf.borderStyle = .none
        return tf
    }()

    private let bottomLine: UIView = {
        let bl = UIView()
        bl.backgroundColor = .lightGray
        return bl
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.textColor = .white
        return tf
    }()


    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.titleLabel?.tintColor = .white
        btn.tintColor = .systemTeal
        btn.layer.cornerRadius = 5
        return btn
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    //MARK: - Helpers
    func configureMainUI() {
//        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        view.backgroundColor = .black
    }

    func addSubviews() {
        let allSubviews = [titleLabel, emailContainerView, loginButton]
        allSubviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        emailContainerView.addSubview(emailImage)
        emailContainerView.addSubview(emailTextField)
        emailContainerView.addSubview(bottomLine)
        emailImage.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: - Constraints
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        addSubviews()

        let layout = view.safeAreaLayoutGuide

        let customContraints = [
            titleLabel.topAnchor.constraint(equalTo: layout.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            emailContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailContainerView.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -16),
            emailContainerView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 16),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),

            emailImage.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor),
            emailImage.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor),
            emailImage.heightAnchor.constraint(equalToConstant: 24),
            emailImage.widthAnchor.constraint(equalToConstant: 24),

            emailTextField.rightAnchor.constraint(equalTo: emailContainerView.rightAnchor),
            emailTextField.leftAnchor.constraint(equalTo: emailImage.rightAnchor, constant: 8),
            emailTextField.centerYAnchor.constraint(equalTo: emailContainerView.centerYAnchor),

            bottomLine.heightAnchor.constraint(equalToConstant: 1.5),
            bottomLine.rightAnchor.constraint(equalTo: emailContainerView.rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: emailContainerView.bottomAnchor),
            bottomLine.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor),
        ]

        NSLayoutConstraint.activate(customContraints)
    }

}

