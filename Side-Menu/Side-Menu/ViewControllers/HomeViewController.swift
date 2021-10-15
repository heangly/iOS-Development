//
//  HomeViewControlleer.swift
//  Side-Menu
//
//  Created by Heang Ly on 10/15/21.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    //MARK: - Properties
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helpers
    private func configureUI() {
        title = "Home"
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
    }

    //MARK: - Actions
    @objc private func didTapMenuButton() {
        self.delegate?.didTapMenuButton()
    }
}
