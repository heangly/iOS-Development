//
//  AuthUIHelper.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/2/21.
//

import UIKit

class GenerateUI {
    static func forAuthStackViews() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 30
        return sv
    }

    static func forAuthNavigationBottomButton(firstPart: String, secondPart: String) -> UIButton {
        let btn = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: firstPart, attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: secondPart, attributes: [.foregroundColor: UIColor.mainBlueTint]))
        btn.setAttributedTitle(attributedText, for: .normal)
        return btn
    }

    static func forAuthMainButton(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor(white: 1, alpha: 0.8), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = UIColor.mainBlueTint.withAlphaComponent(0.8)
        btn.layer.cornerRadius = 5
        btn.isUserInteractionEnabled = false
        return btn
    }

    static func forMainLabel() -> UILabel {
        let lb = UILabel()
        lb.text = "uber".uppercased()
        lb.font = UIFont(name: "Avenir-Light", size: 36)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }

    static func forAccountTypeContainerView(withImage image: UIImage, segmentedControl: UISegmentedControl) -> UIView {
        let uiView = UIView()

        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white

        let lineSeperator = UIView()
        lineSeperator.backgroundColor = .lightGray

        [imageView, segmentedControl, lineSeperator].forEach {
            uiView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = [
            imageView.leftAnchor.constraint(equalTo: uiView.leftAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),

            segmentedControl.centerYAnchor.constraint(equalTo: uiView.centerYAnchor, constant: 5),
            segmentedControl.widthAnchor.constraint(equalTo: uiView.widthAnchor),

            lineSeperator.heightAnchor.constraint(equalToConstant: 1.5),
            lineSeperator.rightAnchor.constraint(equalTo: uiView.rightAnchor),
            lineSeperator.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
            lineSeperator.leftAnchor.constraint(equalTo: uiView.leftAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        return uiView
    }

    static func forInputTextFieldContainerView(withImage image: UIImage, withTexfield texfield: UITextField) -> UIView {
        let uiView = UIView()

        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white

        let lineSeperator = UIView()
        lineSeperator.backgroundColor = .lightGray

        uiView.addSubview(imageView)
        uiView.addSubview(texfield)
        uiView.addSubview(lineSeperator)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        texfield.translatesAutoresizingMaskIntoConstraints = false
        lineSeperator.translatesAutoresizingMaskIntoConstraints = false

        imageView.leftAnchor.constraint(equalTo: uiView.leftAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: uiView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        texfield.rightAnchor.constraint(equalTo: uiView.rightAnchor).isActive = true
        texfield.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        texfield.centerYAnchor.constraint(equalTo: uiView.centerYAnchor).isActive = true

        lineSeperator.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        lineSeperator.rightAnchor.constraint(equalTo: uiView.rightAnchor).isActive = true
        lineSeperator.bottomAnchor.constraint(equalTo: uiView.bottomAnchor).isActive = true
        lineSeperator.leftAnchor.constraint(equalTo: uiView.leftAnchor).isActive = true

        return uiView
    }

    static func forTextField(withPlaceHolder placeholder: String, isSecureText: Bool = false) -> UITextField {
        let tf = UITextField()
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.lightGray])
        tf.attributedPlaceholder = attributedPlaceholder
        tf.textColor = .white
        tf.isSecureTextEntry = isSecureText
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.keyboardAppearance = .dark
        tf.borderStyle = .none
        tf.autocapitalizationType = .none
        return tf
    }


}
