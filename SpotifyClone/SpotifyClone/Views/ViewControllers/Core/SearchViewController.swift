//
//  SearchViewController.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - Properties
    //    private let viewModel = <#viewModel#>
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubViewsAndConstraints()
    }
    
    func configureUI() {
        title = "Search"
        view.backgroundColor = .systemBackground
    }
    //MARK: - Add Subviews & Constraints
    func addSubViewsAndConstraints() {
        
        let allSubviews: [UIView] = []
        allSubviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let layout = view.layoutMarginsGuide
        let allConstraints: [NSLayoutConstraint] = []
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
}


