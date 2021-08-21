//
//  MainTabTableViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit
import YPImagePicker

class MainTabTableViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    func configureViewController() {
        tabBar.tintColor = .black

        self.delegate = self

        let layout = UICollectionViewFlowLayout()
        let feedVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: FeedViewController(collectionViewLayout: layout))

        let searchVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"), rootViewController: SearchViewController())

        let imageSelectorVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorViewController())

        let notificationVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "like_selected"), unselectedImage: #imageLiteral(resourceName: "like_unselected"), rootViewController: NotificationViewController())

        let profileVC = templateNavigationController(selectedImage: #imageLiteral(resourceName: "profile_selected"), unselectedImage: #imageLiteral(resourceName: "profile_unselected"), rootViewController: ProfileViewController(collectionViewLayout: layout))

        setViewControllers([feedVC, searchVC, imageSelectorVC, notificationVC, profileVC], animated: false)
    }

    func templateNavigationController(selectedImage: UIImage, unselectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        return nav
    }

    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                let nav = UINavigationController(rootViewController: UploadPostController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
     
        }
    }

}


extension MainTabTableViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)

        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1

            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            didFinishPickingMedia(picker)
        }

        return true
    }
}
