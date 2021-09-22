//
//  FeedView.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/21/21.
//

import UIKit

protocol FeedViewDelegate: AnyObject {
//    func setProfileImageToNavBar(_ feedView: FeedView, profileImage: UIImageView)
}

class FeedView: UIView {
    //MARK: - Properties
    weak var delegate: FeedViewDelegate?

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addAllSubViews()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helpers
    func configureUI() {
        backgroundColor = .white
    }
    

    //MARK: - AddSubviews
    func addAllSubViews() {

    }

    //MARK: - Constraints
    override func layoutSubviews() {
        super.layoutSubviews()

        let layout = safeAreaLayoutGuide

        NSLayoutConstraint.activate([

            ])
    }
}
