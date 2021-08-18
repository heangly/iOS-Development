//
//  ProfileHeader.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/13/21.
//

import UIKit
import SDWebImage

protocol ProfileHeaderDelegate: class {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}

class ProfileHeader: UICollectionReusableView {
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }

    weak var delegate: ProfileHeaderDelegate?

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.heightAnchor.constraint(equalToConstant: 80).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 80).isActive = true
        iv.layer.cornerRadius = 80 / 2
        iv.backgroundColor = .lightGray
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private let editProfileFollowButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 0.5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return btn
    }()

    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedStatText(value: 5, label: "posts")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedStatText(value: 2, label: "followers")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var followingsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedStatText(value: 1, label: "following")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let gridButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return btn
    }()

    private let listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()

    private let bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true

        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12).isActive = true
//        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        nameLabel.centerX(inView: profileImageView)

        addSubview(editProfileFollowButton)
        editProfileFollowButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileFollowButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
        editProfileFollowButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        editProfileFollowButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true

        let stack = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingsLabel])
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerY(inView: profileImageView)
        stack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        stack.distribution = .fillEqually

        let buttonStacks = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        addSubview(buttonStacks)
        buttonStacks.translatesAutoresizingMaskIntoConstraints = false
        buttonStacks.distribution = .fillEqually
        buttonStacks.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonStacks.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        buttonStacks.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        buttonStacks.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        addSubview(topDivider)
        topDivider.translatesAutoresizingMaskIntoConstraints = false
        topDivider.topAnchor.constraint(equalTo: buttonStacks.topAnchor).isActive = true
        topDivider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topDivider.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topDivider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        addSubview(bottomDivider)
        bottomDivider.translatesAutoresizingMaskIntoConstraints = false
        bottomDivider.topAnchor.constraint(equalTo: buttonStacks.bottomAnchor).isActive = true
        bottomDivider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomDivider.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Actions
    @objc func handleEditProfileFollowTapped() {
        guard let viewModel = viewModel else { return }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }

    //MARK: - Helpers
    func configure() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColorq
    }


    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
}

