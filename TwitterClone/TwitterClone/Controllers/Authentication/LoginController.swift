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

    func configureUI() {
        configureNavigationBar()
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }

}

//MARK: - LoginView Delegate
extension LoginController: LoginViewDelegate {
    func didTapLoginButton(_ loginView: LoginView, email: String, password: String) {
        AuthenticationAPI.shared.loginUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEbUBG: Error logging in \(error.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                let controller = MainTabController()
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }

    func didTapDontHaveAccountButton(_ loginView: LoginView) {
        let controller = SignUpController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

}
