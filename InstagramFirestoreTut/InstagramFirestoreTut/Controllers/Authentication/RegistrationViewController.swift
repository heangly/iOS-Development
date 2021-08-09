//
//  RegistrationViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/9/21.
//

import UIKit

class RegisterationViewController: UIViewController {
    //MARK: - Properties

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helper
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}
