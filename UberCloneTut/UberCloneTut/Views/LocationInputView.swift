//
//  LocationInputView.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/5/21.
//

import UIKit

protocol LocationInputViewDelegate: class {
    func dimissLocationInputView()
}

class LocationInputView: UIView {
    //MARK: - Properties
    weak var delegate: LocationInputViewDelegate?

    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp-1").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleBackTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureMainUI()
        addAllSubViews()
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Actions
    @objc func handleBackTapped(){
        delegate?.dimissLocationInputView()
    }
    
    //MARK: - Helpers
    func configureMainUI(){
        backgroundColor = .white
        addShadow()
    }
    
    func addAllSubViews(){
        let subviews = [backButton]
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func addAllConstraints(){
        let constraints = [
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
