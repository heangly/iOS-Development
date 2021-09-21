//
//  ViewController.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    //MARK: - Properties
    private var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }

    let actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.backgroundColor = .twitterBlue
        btn.setImage(UIImage(named: "new_tweet"), for: .normal)
        btn.layer.cornerRadius = 56 / 2
        btn.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return btn
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addAllSubviews()
        fetchUser()
    }

    //MARK: - Helpers
    func configureUI() {
        let feed = configureTabBar(viewController: FeedController(), imageName: "home_unselected")
        let explore = configureTabBar(viewController: ExploreController(), imageName: "search_unselected")
        let notification = configureTabBar(viewController: NotificationController(), imageName: "like_unselected")
        let conversation = configureTabBar(viewController: ConversationController(), imageName: "ic_mail_outline_white_2x-1")

        viewControllers = [feed, explore, notification, conversation]
    }

    func configureTabBar(viewController: UIViewController, imageName: String) -> UINavigationController {
        let vc = UINavigationController(rootViewController: viewController)
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.navigationBar.barTintColor = .white
        return vc
    }

    //MARK: - Actions
    @objc func actionButtonTapped() {
        let ac = UIAlertController(title: "Logout?", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.logout()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

    func logout() {
        do {
            try Auth.auth().signOut()

            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }

        } catch {
            print("Error logout user -> \(error.localizedDescription)")
        }

    }

    //MARK: - API
    func fetchUser() {
        UserAPI.shared.fetchUser { user in
            self.user = user
        }
    }
}

//MARK: - Constraints & Subviews
extension MainTabController {
    func addAllSubviews() {
        let subviews = [actionButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let layout = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 56),
            actionButton.widthAnchor.constraint(equalToConstant: 56),
            actionButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -64),
            actionButton.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -16),
            ])
    }

}



