//
//  LoginController.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    private let loginView = LoginView()
    
    //MARK: - LifeCycle
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        configureUI()
    }
    
    func configureUI(){
        configureNavigationBar()
        
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }

}

//MARK: - LoginView Delegate
extension LoginController : LoginViewDelegate {
    func didTapLoginButton(_ loginView: LoginView) {
        print("Login Tapped")
    }
    
    func didTapDontHaveAccountButton(_ loginView: LoginView) {
        print("dont have account")
    }
    
}
