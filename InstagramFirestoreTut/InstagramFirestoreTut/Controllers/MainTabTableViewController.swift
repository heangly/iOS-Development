//
//  MainTabTableViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

class MainTabTableViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }

    func configureViewController() {
        tabBar.tintColor = .black
        let layout = UICollectionViewFlowLayout()
        let feedVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: FeedViewController(collectionViewLayout: layout))
        
        let searchVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"), rootViewController: SearchViewController())
        
        let imageSelectorVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorViewController())
        
        let notificationVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "like_selected"), unselectedImage: #imageLiteral(resourceName: "like_unselected"), rootViewController:  NotificationViewController())
        
        let profileVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "profile_selected"), unselectedImage: #imageLiteral(resourceName: "profile_unselected"), rootViewController: ProfileViewController(collectionViewLayout: layout))
        
        setViewControllers([feedVC, searchVC, imageSelectorVC, notificationVC, profileVC], animated: false)
    }

    func templateNavigationController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        return nav
    }

}
