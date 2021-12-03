//
//  FeedCollectionViewCell.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/25/21.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let id = "FeedCollectionViewCell"

    private let profileImageView: UIImageView = {
        let uv = UIImageView()
        uv.contentMode = .scaleAspectFit
        uv.clipsToBounds = true
        uv.layer.cornerRadius = 48 / 2
        uv.backgroundColor = .twitterBlue
        return uv
    }()

    private let captionLabel: UILabel = {
        let ul = UILabel()
        ul.font = UIFont.systemFont(ofSize: 14)
        ul.numberOfLines = 0
        ul.text = "some test caption"
        return ul
    }()

    private let infoLabel = UILabel()

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()

    private lazy var commentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "comment"), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var retweetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "retweet"), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(retweetButtonTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "like"), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "share"), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return btn
    }()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainUI()
        addSubViewsAndConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    func configureMainUI() {
        backgroundColor = .white
    }
    
    func configureTweetCell(with tweet: Tweet){
        captionLabel.text = tweet.caption
        
    }

    //MARK: - Actions
    @objc func commentButtonTapped() {
        print("DEBUG: comment button tapped")
    }

    @objc func retweetButtonTapped() {
        print("DEBUG: retweet button tapped")
    }

    @objc func likeButtonTapped() {
        print("DEBUG: like button tapped")
    }

    @objc func shareButtonTapped() {
        print("DEBUG: share button tapped")
    }


    //MARK: - add all subviews and constraints
    func addSubViewsAndConstraints() {

        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.arrangedSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4

        infoLabel.text = "Eddie Brock @venom"
        infoLabel.font = UIFont.systemFont(ofSize: 14)

        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.arrangedSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        actionStack.axis = .horizontal
        actionStack.spacing = 72

        let allSubViews = [profileImageView, stack, actionStack, underlineView]
        allSubViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        let allConstraints = [
            profileImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
            profileImageView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 8),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),

            stack.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            stack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            stack.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -12),

            actionStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            underlineView.leftAnchor.constraint(equalTo: leftAnchor),
            underlineView.rightAnchor.constraint(equalTo: rightAnchor),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 1),
        ]

        NSLayoutConstraint.activate(allConstraints)
    }

}





