//
//  LibraryViewController.swift
//  SpotifyCloneProgrammaticallyUI
//
//  Created by Heang Ly on 8/5/21.
//

import UIKit

class LibraryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }


    func configureUI() {
        title = "Library"
        view.backgroundColor = .systemBackground
    }

}
