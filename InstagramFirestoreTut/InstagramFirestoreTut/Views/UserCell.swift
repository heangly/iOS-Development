//
//  UserCell.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/17/21.
//

import UIKit

class UserCell: UITableViewCell {
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Venom"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Eddie Brock"
        label.textColor = .lightGray
        return label
    }()


    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    //MARK: - Helpers
    func configureUI() {
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        profileImageView.centerY(inView: self)
        
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.centerY(inView: profileImageView)
        stackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
