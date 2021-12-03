//
//  ViewController.swift
//  LetsMeet
//
//  Created by Heang Ly on 10/31/21.
//

import UIKit

class MainTabController: UITabBarController {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }
    
    //MARK: - Helper
    private func configureMainUI(){
        view.backgroundColor = .systemPink
    }


}

