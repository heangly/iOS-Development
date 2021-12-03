
//
//  InputTextField.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/21/21.
//

import UIKit

class InputTextView: UITextView {
    //MARK: - properties
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }

    var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()

    var placeholderShouldCenter = true {
        didSet {
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            if placeholderShouldCenter {
                placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
                placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
                placeholderLabel.centerY(inView: self)
            } else {
                placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
                placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
            }
        }
    }

    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        addSubview(placeholderLabel)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Actions
    @objc func handleDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
