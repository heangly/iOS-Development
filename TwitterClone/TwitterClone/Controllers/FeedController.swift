//
//  FeedConotroller.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

class FeedController: UIViewController {
    //MARK: - Properties
    private let feedView = FeedView()
    
    var user: User? {
        didSet {
            profileImage.
        }
    }

    private let profileImage: UIImageView = {
        let uv = UIImageView()
        uv.backgroundColor = .twitterBlue
        uv.layer.cornerRadius = 32 / 2
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.heightAnchor.constraint(equalToConstant: 32).isActive = true
        uv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return uv
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helpers
    func configureUI() {
        view = feedView
        configureNavBar()
    }

    func configureNavBar() {
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }
}
