//
//  FeedConotroller.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    //MARK: - Properties
    private let feedView = FeedView()

    var user: User? {
        didSet {
            configureLeftNavBar()
        }
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helpers
    func configureUI() {
        view = feedView
        configureMidNavBar()
        configureLeftNavBar()
    }
    
    func configureMidNavBar(){
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        navigationItem.titleView = imageView
    }

    func configureLeftNavBar() {
        guard let user = user else { return }
        let profileImage = UIImageView()
        profileImage.layer.cornerRadius = 32 / 2
        profileImage.clipsToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImage.sd_setImage(with: user.profileImageUrl)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }


}
