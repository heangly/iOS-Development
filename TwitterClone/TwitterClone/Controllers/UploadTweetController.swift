//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/22/21.
//

import UIKit

class UploadTweetController: UIViewController {
    //MARK: - Properties
    private let uploadTweetView = UploadTweetView()

    private var viewModel: UploadTweetViewModel? {
        didSet {
            viewModel?.profileImageUrl = user.profileImageUrl
        }
    }

    private let user: User

    //MARK: - LifeCycle
    override func loadView() {
        view = uploadTweetView
        viewModel = UploadTweetViewModel(view: uploadTweetView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    func configureUI() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        configureNavBarLeftItem()
        configureNarBarRightItem()
    }

    func configureNavBarLeftItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }

    func configureNarBarRightItem() {
        let tweetButton = UIButton(type: .system)
        tweetButton.backgroundColor = .twitterBlue
        tweetButton.setTitle("Tweet", for: .normal)
        tweetButton.titleLabel?.textAlignment = .center
        tweetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tweetButton.setTitleColor(.white, for: .normal)
        tweetButton.layer.cornerRadius = 32 / 2
        tweetButton.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        tweetButton.addTarget(self, action: #selector(tweetButtonTapped), for: .touchUpInside)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }

    //MARK: - Actions
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func tweetButtonTapped() {
        print("tweet")
    }

}

