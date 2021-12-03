//
//  HomeViewController.swift
//  Own-Side-Menu
//
//  Created by Heang Ly on 10/16/21.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    //MARK: - Properties
    weak var delegate: HomeViewControllerDelegate?

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helpers
    private func configureUI() {
        title = "Home"
        view.backgroundColor = .white
        configureNavBar()
    }

    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(menuButtonTapped))
    }

    //MARK: - Actions
    @objc private func menuButtonTapped() {
        delegate?.didTapMenuButton()
    }


}
