//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    func configureMainUI() {
        title = "Home"
        view.backgroundColor = .systemBackground
    }

}

