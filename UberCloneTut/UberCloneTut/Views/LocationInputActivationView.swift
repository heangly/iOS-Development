//
//  LocationInputActivationView.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/5/21.
//

import UIKit

protocol LocationInputActivationViewDelegate: class {
    func presentLocationInputView()
}

class LocationInputActivationView: UIView {
    //MARK: - Properties
    weak var delegate: LocationInputActivationViewDelegate?

    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleShowLocationInputView))
        addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Actions
    @objc func handleShowLocationInputView(){
        delegate?.presentLocationInputView()
    }

    //MARK: - Helpers
    func configureMainUI() {
        backgroundColor = .white
        addShadow()
        addAllSubViews()
        addAllConstraints()
    }

    func addAllSubViews() {
        let subviews = [indicatorView, placeholderLabel]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func addAllConstraints(){
        let constraints = [
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            indicatorView.heightAnchor.constraint(equalToConstant: 6),
            indicatorView.widthAnchor.constraint(equalToConstant: 6),
            
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderLabel.leftAnchor.constraint(equalTo: indicatorView.rightAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }


}
