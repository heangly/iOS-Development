//
//  LocationCell.swift
//  UberClone
//
//  Created by Heang Ly on 9/6/21.
//

import UIKit

class LocationCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "Location Cell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "123"
        return label
    }()
    
    private let addressLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "123"
        label.textColor = .lightGray
        return label
    }()
    
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMainUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configureMainUI(){
        selectionStyle = .none
        addSubViewsAndConstraints()
    }
    
    func addSubViewsAndConstraints(){
        let stackView = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(stackView)
        }
        
        let layout = safeAreaLayoutGuide
        
        let constraints = [
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 12)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
