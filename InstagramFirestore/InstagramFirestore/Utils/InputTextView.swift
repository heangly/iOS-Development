//
//  InputTextView.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/3/21.
//

import UIKit

class InputTextView: UITextView {
    //MARK: - Properties
    var placeholderText: String? {
        didSet { placehholderLabel.text = placeholderText }
    }
    
    private let placehholderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placehholderLabel)
        placehholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func handleTextDidChange(){
        placehholderLabel.isHidden = !text.isEmpty
    }
}
