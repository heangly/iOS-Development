//
//  CommentInputAccessoryView.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/26/21.
//

import UIKit

protocol CommentInputAccessoryViewDelegate: class {
    func inputView(_ inputView: CommentInputAccessoryView, wantsToUploadComment comment: String)
}

class CommentInputAccessoryView: UIView {
    //MARK: - Properties
    weak var delegate: CommentInputAccessoryViewDelegate?

    private let commentTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter comment..."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        tv.placeholderShouldCenter = false
        return tv
    }()

    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()

    private let divider: UIView = {
        let uv = UIView()
        uv.backgroundColor = .lightGray
        return uv
    }()

    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - Actions
    @objc func handlePostTapped() {
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    func clearCommentTextView(){
        commentTextView.text = nil
        commentTextView.placeholderLabel.isHidden = false
    }

    //MARK: - Helpers
    override func layoutSubviews() {
        super.layoutSubviews()

        let allSubViews = [postButton, commentTextView, divider]
        allSubViews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = [
            divider.topAnchor.constraint(equalTo: topAnchor),
            divider.leftAnchor.constraint(equalTo: leftAnchor),
            divider.rightAnchor.constraint(equalTo: rightAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5),

            postButton.topAnchor.constraint(equalTo: topAnchor),
            postButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            postButton.heightAnchor.constraint(equalToConstant: 50),
            postButton.widthAnchor.constraint(equalToConstant: 50),

            commentTextView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentTextView.rightAnchor.constraint(equalTo: postButton.leftAnchor, constant: -8),
            commentTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 8),
            commentTextView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
        ]

        NSLayoutConstraint.activate(constraints)
    }



}
