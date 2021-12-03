//
//  TabBarViewControlller.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav1 = UINavigationController(rootViewController: HomeViewController())
        nav1.title = "Browse"
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        
        let nav2 = UINavigationController(rootViewController: SearchViewController())
        nav2.title = "Search"
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let nav3 = UINavigationController(rootViewController: LibraryViewController())
        nav3.title = "Library"
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        let allNavs = [nav1, nav2, nav3]
        allNavs.forEach {
            $0.navigationItem.largeTitleDisplayMode = .always
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationBar.tintColor = .label
        }
        
        setViewControllers(allNavs, animated: false)
    }
    

}
