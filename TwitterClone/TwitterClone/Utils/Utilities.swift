//
//  Utilities.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/19/21.
//

import UIKit

class Utilities {
    func inputContainerView(withImage image: UIImage, withTextField textField: UITextField, withTextFieldPlaceholder placeholder: String, isSecureTextEntry: Bool = false) -> UIView {

        let containerView = UIView()

        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white

        let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 20)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.textColor = .white
        textField.isSecureTextEntry = isSecureTextEntry
        textField.autocapitalizationType = .none

        let bottomLine = UIView()
        bottomLine.backgroundColor = .white

        [imageView, textField, bottomLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),

            textField.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            textField.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),

            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])

        return containerView
    }

    func stackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        return stackView
    }

    func authButton(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.twitterBlue, for: .normal)
        return btn
    }

    func attributeTextButton(firstPartTitle firstPart: String, secondPartTitle secondPart: String) -> UIButton {
        let btn = UIButton(type: .system)

        let firstPartAttributedString = NSMutableAttributedString(string: firstPart, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 16)])
        let secondPartAttributedString = NSAttributedString(string: secondPart, attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 16)])

        let attributedTitle = firstPartAttributedString
        attributedTitle.append(secondPartAttributedString)

        btn.setAttributedTitle(attributedTitle, for: .normal)
        return btn
    }
}
