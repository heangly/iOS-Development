//
//  UploadTweetView.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/22/21.
//

import UIKit

class UploadTweetView: UIView, UITextViewDelegate {
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let uv = UIImageView()
        uv.contentMode = .scaleAspectFit
        uv.clipsToBounds = true
        uv.layer.cornerRadius = 48 / 2
        uv.backgroundColor = .twitterBlue
        return uv
    }()

    private let placeholderLabel: UILabel = {
        let ul = UILabel()
        ul.font = UIFont.systemFont(ofSize: 16)
        ul.textColor = .darkGray
        ul.text = "What is happening?"
        return ul
    }()

    private let textView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()

    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        return sv
    }()

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
        textView.delegate = self
    }

    func configureProfileImageView(imageURL: URL) {
        profileImageView.sd_setImage(with: imageURL)
    }

    //MARK: - Actions
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

    //MARK: - AddSubviews
    func addAllSubViews() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(placeholderLabel)

        let subStackViews = [profileImageView, textView]
        subStackViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }

        let subviews = [stackView]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    //MARK: - Constraints
    override func layoutSubviews() {
        super.layoutSubviews()

        let layout = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),

            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 84),

            stackView.topAnchor.constraint(equalTo: layout.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20),
            ])
    }
}
