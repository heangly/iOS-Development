//
//  NotificationCell.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/30/21.
//

import UIKit

class NotificationCell: UITableViewCell {
    //MARK: - Properties
    var viewModel: NotificationViewModel? {
        didSet { configure() }
    }

    static var reusableIdentifier = "Notification Cell"

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.layer.cornerRadius = 48 / 2
        return iv
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "venom"
        label.numberOfLines = 0
        return label
    }()

    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()

    private let followButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Loading", for: .normal)
        btn.titleLabel?.tintColor = .black
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 0.5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return btn
    }()


    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: NotificationCell.reusableIdentifier)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell() {
        backgroundColor = .white
        selectionStyle = .none
        followButton.isHidden = true
        configureContraint()
    }

    func configureContraint() {
        [profileImageView, infoLabel, followButton, postImageView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let customConstraints = [
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            infoLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            infoLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),

            followButton.widthAnchor.constraint(equalToConstant: 100),
            followButton.heightAnchor.constraint(equalToConstant: 32),
            followButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            followButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),

            postImageView.widthAnchor.constraint(equalToConstant: 40),
            postImageView.heightAnchor.constraint(equalToConstant: 40),
            postImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            postImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),

        ]

        NSLayoutConstraint.activate(customConstraints)
    }


    //MARK: - Actions
    @objc func handleFollowTapped() {

    }

    @objc func handlePostTapped() {

    }

    func configure() {
        guard let viewModel = viewModel else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        postImageView.sd_setImage(with: viewModel.postImageUrl, completed: nil)
        infoLabel.attributedText = viewModel.notificationMessage
    }
}
