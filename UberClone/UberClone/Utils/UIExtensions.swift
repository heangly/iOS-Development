//
//  Extensions.swift
//  UberClone
//
//  Created by Heang Ly on 9/2/21.
//

import UIKit

extension UIStackView {
    func authStackViews() -> UIStackView{
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 30
        return sv
    }
}

extension UIButton {
    func authNavigationBottomButton(firstPart: String, secondPart: String) -> UIButton {
        let btn = UIButton(type: .system)
        let attributedText = NSMutableAttributedString(string: firstPart, attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.lightGray])
        attributedText.append(NSAttributedString(string: secondPart, attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.mainBlueTint.withAlphaComponent(0.8)]))
        btn.setAttributedTitle(attributedText, for: .normal)
        return btn
    }
    
    func authMainButton(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = UIColor.mainBlueTint.withAlphaComponent(0.8)
        btn.layer.cornerRadius = 5
        btn.isUserInteractionEnabled = false
        return btn
    }
}

extension UILabel {
    func uberLabel() -> UILabel {
        let lb = UILabel()
        lb.text = "uber".uppercased()
        lb.font = UIFont(name: "Avenir-Light", size: 36)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }

    static let backgroundColor = UIColor.rgb(red: 25, green: 25, blue: 25)
    static let mainBlueTint = UIColor.rgb(red: 17, green: 154, blue: 237)
}

extension UIView {
    func accountTypeFieldContainerView(withImage image: UIImage, segmentedControl: UISegmentedControl) -> UIView {
        let uiView = UIView()

        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white

        let lineSeperator = UIView()
        lineSeperator.backgroundColor = .lightGray

        uiView.addSubview(imageView)
        uiView.addSubview(segmentedControl)
        uiView.addSubview(lineSeperator)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        lineSeperator.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leftAnchor.constraint(equalTo: uiView.leftAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        segmentedControl.centerYAnchor.constraint(equalTo: uiView.centerYAnchor, constant: 5).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: uiView.widthAnchor).isActive = true
     
        lineSeperator.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        lineSeperator.rightAnchor.constraint(equalTo: uiView.rightAnchor).isActive = true
        lineSeperator.bottomAnchor.constraint(equalTo: uiView.bottomAnchor).isActive = true
        lineSeperator.leftAnchor.constraint(equalTo: uiView.leftAnchor).isActive = true

        return uiView
    }
    
    func inputTextFieldContainerView(withImage image: UIImage, withTexfield texfield: UITextField) -> UIView {
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
}

extension UITextField {
    func textField(withPlaceHolder placeholder: String, isSecureText: Bool = false) -> UITextField {
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
