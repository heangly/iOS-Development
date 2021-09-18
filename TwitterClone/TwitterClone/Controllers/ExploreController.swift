//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

class ExploreController: UIViewController {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        
    }
}
