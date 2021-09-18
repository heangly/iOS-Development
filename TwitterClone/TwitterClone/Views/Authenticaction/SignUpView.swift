//
//  SignUpView.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit

class SignUpView: UIView {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddSubviews
    func addAllSubViews(){
        
    }
    
    //MARK: - Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
        ])
    }
}
