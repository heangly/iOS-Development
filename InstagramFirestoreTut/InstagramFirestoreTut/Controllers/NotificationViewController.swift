//
//  NotificationViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/7/21.
//

import UIKit

class NotificationViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Notification"
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.reusableID)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
}

//MARK: - TableviewDataSource
extension NotificationViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.reusableID, for: indexPath) as! NotificationCell
        return cell
    }
}
