//
//  ViewController.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

class MainTabController: UITabBarController {
    //MARK: - Properties
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
    @objc func actionButtonTapped(){
        print("Action button tapped")
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



