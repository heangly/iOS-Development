//
//  WelcomeViewController.swift
//  SpotifyCloneProgrammaticallyUI
//
//  Created by Heang Ly on 8/5/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI(){
        title = "Spotify"
        view.backgroundColor = .systemGreen
    
    }
}
