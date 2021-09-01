//
//  ViewController.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/1/21.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = "uber".uppercased()
        tl.textColor = .white
        tl.font = UIFont.systemFont(ofSize: 38)
        return tl
    }()

    private let emailContainer: UIView = {
        let ec = UIView()
        return ec
    }()

    private let emailImage: UIImageView = {
        let ei = UIImageView()
        ei.image = #imageLiteral(resourceName: "ic_mail_outline_white_2x")
        ei.tintColor = .white
        return ei
    }()

    private let emailTextField: UITextField = {
        let et = UITextField()
        let attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.lightGray])
        et.attributedPlaceholder = attributedPlaceholder
        et.textColor = .white
        et.font = UIFont.systemFont(ofSize: 18)
        et.keyboardAppearance = .dark
        et.autocapitalizationType = .none
        return et
    }()

    private let emailLineSeperator: UIView = {
        let ls = UIView()
        ls.backgroundColor = .lightGray
        return ls
    }()
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }


    //MARK: - Helpers
    func configureMainUI() {
        view.backgroundColor = .black
    }
}

//MARK: - Add Subviews & Constraints
extension LoginController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addAllSubviews()
        addAllConstraints()
    }

    func addAllSubviews() {
        let allSubviews = [titleLabel, emailContainer]
        allSubviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        emailContainer.addSubview(emailImage)
        emailContainer.addSubview(emailTextField)
        emailContainer.addSubview(emailLineSeperator)
        emailImage.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailLineSeperator.translatesAutoresizingMaskIntoConstraints = false
    }

    func addAllConstraints() {
        let layout = view.safeAreaLayoutGuide

        let customConstraints = [
            titleLabel.topAnchor.constraint(equalTo: layout.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            emailContainer.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 32),
            emailContainer.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -32),
            emailContainer.heightAnchor.constraint(equalToConstant: 50),
            
            emailImage.leftAnchor.constraint(equalTo: emailContainer.leftAnchor),
            emailImage.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor),
            emailImage.heightAnchor.constraint(equalToConstant: 24),
            emailImage.widthAnchor.constraint(equalToConstant: 24),
            
            emailTextField.leftAnchor.constraint(equalTo: emailImage.rightAnchor, constant: 8),
            emailTextField.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor),
            
            emailLineSeperator.leftAnchor.constraint(equalTo: emailContainer.leftAnchor),
            emailLineSeperator.rightAnchor.constraint(equalTo: emailContainer.rightAnchor),
            emailLineSeperator.bottomAnchor.constraint(equalTo: emailContainer.bottomAnchor),
            emailLineSeperator.heightAnchor.constraint(equalToConstant: 1.5),
        ]
        
        NSLayoutConstraint.activate(customConstraints)
    }
    
}
