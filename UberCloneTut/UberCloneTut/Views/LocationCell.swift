//
//  LocationCell.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/6/21.
//

import UIKit

class LocationCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "Location Cell"
    
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
        
    }
}
