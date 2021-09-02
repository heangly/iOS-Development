//
//  ViewController.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/1/21.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    private let titleLabel = GenerateUI.forMainLabel()

    private let emailContainer: UIView = {
        let tf = GenerateUI.forTextField(withPlaceHolder: "Email")
        return GenerateUI.forInputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), withTexfield: tf)
    }()
    
    private let passwordContainer: UIView = {
        let tf = GenerateUI.forTextField(withPlaceHolder: "Passwordd")
        return GenerateUI.forInputTextFieldContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), withTexfield: tf)
    }()

    private let loginButton = GenerateUI.forAuthMainButton(title: "Sign In")
    
    private let dontHaveAccountButton: UIButton = {
        let btn = GenerateUI.forAuthNavigationBottomButton(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()
    

    private let stackViews = GenerateUI.forAuthStackViews()
    
    //MARK: - Actions
    @objc func handleShowSignUp(){
        let controller = SignupController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }


    //MARK: - Helpers
    func configureMainUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}

//MARK: - Add Subviews & Constraints
extension LoginController {
    func addAllSubviews() {
        let allSubviews = [titleLabel, stackViews, dontHaveAccountButton]
        allSubviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let subViewsInStackViews = [emailContainer, passwordContainer, loginButton]
        subViewsInStackViews.forEach {
            stackViews.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        stackViews.setCustomSpacing(50, after: passwordContainer)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addAllSubviews()
        
        let layout = view.safeAreaLayoutGuide
        
        let customContraints = [
             titleLabel.topAnchor.constraint(equalTo: layout.topAnchor, constant: 32),
             titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

             stackViews.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
             stackViews.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -32),
             stackViews.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 32),

             dontHaveAccountButton.topAnchor.constraint(greaterThanOrEqualTo: stackViews.bottomAnchor, constant: 10),
             dontHaveAccountButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -10),
             dontHaveAccountButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor),
         ]

         NSLayoutConstraint.activate(customContraints)
    }
}
