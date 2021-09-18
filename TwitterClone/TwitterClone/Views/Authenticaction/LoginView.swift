//
//  LoginView.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

class LoginView: UIView {
    //MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()

    private lazy var emailContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private let emailImage: UIImageView = {
        let ei = UIImageView()
        ei.image = #imageLiteral(resourceName: "mail")
        ei.tintColor = .white
        return ei
    }()

    private let emailTextField: UITextField = {
        let et = UITextField()
        et.placeholder = "Email"
        return et
    }()

    private let emailBottomLine: UIView = {
        let el = UIView()
        el.backgroundColor = .white
        return el
    }()

    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private let passwordImage: UIImageView = {
        let pi = UIImageView()
        pi.image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        pi.tintColor = .white
        return pi
    }()

    private let passwordTextField: UITextField = {
        let pt = UITextField()
        pt.placeholder = "password"
        return pt
    }()
    
    private let passwordBottomLine: UIView = {
        let pl = UIView()
        pl.backgroundColor = .white
        return pl
    }()


    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
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

    //MARK: - AddSubviews
    func addAllSubViews() {
        let emailContainerSubViews = [emailImage, emailTextField, emailBottomLine]
        emailContainerSubViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            emailContainerView.addSubview($0)
        }
        
        let passwordContainerSubViews = [passwordImage, passwordTextField, passwordBottomLine]
        passwordContainerSubViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            passwordContainerView.addSubview($0)
        }
        
        let subStackViews = [emailContainerView, passwordContainerView]
        subStackViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }

        let subViews = [logoImageView, stackView]
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
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: layout.topAnchor),

            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: layout.rightAnchor, constant:  -40),

            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            passwordContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            emailImage.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor),
            
            emailTextField.leftAnchor.constraint(equalTo: emailImage.rightAnchor, constant: 10),
            
            emailBottomLine.heightAnchor.constraint(equalToConstant: 2),
            emailBottomLine.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor),
            emailBottomLine.rightAnchor.constraint(equalTo: emailContainerView.rightAnchor),
            emailBottomLine.bottomAnchor.constraint(equalTo: emailImage.bottomAnchor, constant: 10),

            ])
    }
}
