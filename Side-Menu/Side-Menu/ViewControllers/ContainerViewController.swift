//
//  ViewController.swift
//  Side-Menu
//
//  Created by Heang Ly on 10/15/21.
//

import UIKit

enum MenuState {
    case opened
    case closed
}

class ContainerViewController: UIViewController {
    private var menuState: MenuState = .closed

    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    lazy var infoVC = InfoViewController()
    var navVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addChildVCs()
    }

    private func configureUI() {
        view.backgroundColor = .systemPink
    }

    private func addChildVCs() {
        // Menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        menuVC.delegate = self

        // Home
        let navVC = UINavigationController(rootViewController: homeVC)
        homeVC.delegate = self
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

//MARK: - HomeViewController Delegate
extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }

    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
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


//MARK: - MenuViewController Delegate
extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuOptions) {
        toggleMenu { [weak self] in
            switch menuItem {
            case .home:
                self?.resetToHome()
            case .info:
                self?.addInfo()
            case .appRating:
                break
            case .shareApp:
                break
            case .settings:
                break
            }
        }

    }

    private func addInfo() {
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    private func resetToHome(){
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }


}
