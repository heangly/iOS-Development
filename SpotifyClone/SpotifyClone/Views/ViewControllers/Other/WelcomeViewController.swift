//
//  WelcomeViewController.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    //MARK: - Properties
    //    private let viewModel = <#viewModel#>

    private let signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        btn.setTitle("Sign In with Spotify", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return btn
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubViewsAndConstraints()
    }

    //MARK: - Helpers
    func configureUI() {
        title = "Spotify"
        view.backgroundColor = .systemGreen
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //MARK: - Actions
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completionHandler = { [weak self] succcess in
            DispatchQueue.main.async {
                self?.handleSignIn(success: succcess)
            }
        }
        navigationController?.pushViewController(vc, animated: true)

    }

    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something went wrong when signing it", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }


    //MARK: - Add Subviews & Constraints
    func addSubViewsAndConstraints() {
        view.addSubview(signInButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        signInButton.frame = CGRect(
            x: 20,
            y: view.height - 50 - view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50
        )
    }

}


