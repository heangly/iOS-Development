//
//  CommentCell.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/25/21.
//

import UIKit

class CommentCell: UICollectionViewCell {
    static let reusuableIdentifier = "Comment Cell"

    //MARK: - Properties
    var viewModel: CommentViewModel? { didSet { configure() } }

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 40 / 2
        return iv
    }()

    private let commentLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    override func layoutSubviews() {
        super.layoutSubviews()

        [profileImageView, commentLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        commentLabel.numberOfLines = 0

        let contraints = [
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            commentLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            commentLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
            commentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ]

        NSLayoutConstraint.activate(contraints)
    }

    func configure() {
        guard let viewMode = viewModel else { return }
        profileImageView.sd_setImage(with: viewMode.profileImageUrl)
        commentLabel.attributedText = viewMode.commentLabelText()
    }

}
