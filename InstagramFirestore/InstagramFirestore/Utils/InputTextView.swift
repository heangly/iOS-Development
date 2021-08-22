//
//  InputTextView.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/21/21.
//

import UIKit

class InputTextView: UITextView {
    //MARK: - Properties
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func handleTextDidChange(){
        placeholderLabel.isHidden = !text.isEmpty
    }
}
