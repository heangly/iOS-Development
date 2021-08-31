//
//  NotificationViewController.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

class NotificationViewController: UITableViewController {
    //MARK: - Properties
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNotifications()
    }

    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notification"
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.reusableIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }

    //MARK: - API
    func fetchNotifications() {
        NotificationService.fetchNotifications { notifications in
            self.notifications = notifications
            print("DEBUG: Notification \(notifications)")
        }
    }
}


//MARK: - TableViewDataSource
extension NotificationViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.reusableIdentifier, for: indexPath) as! NotificationCell
        return cell
    }
}
