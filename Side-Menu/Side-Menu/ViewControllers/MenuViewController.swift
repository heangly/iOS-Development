//
//  MenuViewController.swift
//  Side-Menu
//
//  Created by Heang Ly on 10/15/21.
//

import UIKit

enum MenuOptions: String, CaseIterable {
    case home = "Home"
    case info = "Information"
    case appRating = "App Rating"
    case shareApp = "Share App"
    case settings = "Settings"

    var imageName: String {
        switch self {

        case .home:
            return "house"
        case .info:
            return "airplane"
        case .appRating:
            return "star"
        case .shareApp:
            return "message"
        case .settings:
            return "gear"
        }
    }
}

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuOptions)
}

class MenuViewController: UIViewController {
    //MARK: - Properties
    weak var delegate: MenuViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tb = UITableView()
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tb.backgroundColor = nil
        return tb
    }()

    private let grayColor = UIColor(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1)

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = grayColor
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
}

//MARK: - UITableViewDelegate & Datasource
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.backgroundColor = grayColor
        cell.textLabel?.textColor = .white
        cell.tintColor = .white
        let imageName = MenuOptions.allCases[indexPath.row].imageName
        cell.imageView?.image = UIImage(systemName: imageName)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
