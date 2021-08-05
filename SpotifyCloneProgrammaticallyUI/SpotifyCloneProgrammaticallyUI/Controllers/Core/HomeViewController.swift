//
//  HomeViewController.swift
//  SpotifyCloneProgrammaticallyUI
//
//  Created by Heang Ly on 8/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }


    func configureUI() {
        title = "Home"
        view.backgroundColor = .systemBackground
    }

}
