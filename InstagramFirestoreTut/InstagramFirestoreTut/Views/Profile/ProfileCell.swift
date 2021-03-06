//
//  ProfileCell.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/13/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    var viewModel: PostViewModel? {
        didSet { configure() }
    }

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        addSubview(imageView)
        imageView.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        guard let viewModel = viewModel else { return }
        imageView.sd_setImage(with: viewModel.imageUrl)
    }
}
