//
//  UserCell.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/17/21.
//

import UIKit

class UserCell: UITableViewCell {
    //MARK: - Properties
    var user: User? {
        didSet {
            usernameLabel.text = user?.username
            fullnameLabel.text = user?.fullname
        }
    }
    
    private let profileImageView: UIImageView = {
        let pv = UIImageView()
        pv.contentMode = .scaleAspectFill
        pv.clipsToBounds = true
        pv.backgroundColor = .lightGray
        pv.image = #imageLiteral(resourceName: "venom-7")
        return pv
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()

    //MARK: - Lifecycle
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

        
        let usernameStack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        addSubview(usernameStack)
        usernameStack.axis = .vertical
        usernameStack.spacing = 4
        usernameStack.translatesAutoresizingMaskIntoConstraints = false
        usernameStack.centerY(inView: profileImageView)
        usernameStack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        

    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
