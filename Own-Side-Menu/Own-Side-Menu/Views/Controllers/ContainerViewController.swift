//
//  ViewController.swift
//  Own-Side-Menu
//
//  Created by Heang Ly on 10/16/21.
//

import UIKit

extension ContainerViewController {
    enum MenuState {
        case opened
        case closed
    }
}

class ContainerViewController: UIViewController {
    //MARK: - Properties
    private var menuState: MenuState = .closed

    private let menuVC = MenuViewController()
    private let homeVC = HomeViewController()
    var containerNavVC: UINavigationController?

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addChildViews()
    }

    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .blue
    }

    private func addChildViews() {
        // MenuVC
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)

        //HomeVC
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        homeVC.delegate = self
        addChild(homeNavVC)
        view.addSubview(homeNavVC.view)
        homeVC.didMove(toParent: self)
        self.containerNavVC = homeNavVC
    }

    //MARK: - Actions


}

//MARK: - HomeViewController Delegate
extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }

    private func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.containerNavVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.containerNavVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

