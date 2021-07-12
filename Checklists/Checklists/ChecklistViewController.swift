//
//  ViewController.swift
//  Checklists
//
//  Created by Heang Ly on 7/11/21.
//

import UIKit

class ChecklistViewController: UITableViewController {
    let row0text = "Walk the dog"
    var row0checked = false

    let row1text = "Brush teeth"
    var row1checked = false

    let row2text = "Learn iOS development"
    var row2checked = false

    let row3text = "Soccer practice"
    var row3checked = false

    let row4text = "Eat ice cream"
    var row4checked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: - Table View Data Source
    func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
        var isChecked = false

        switch indexPath.row {
        case 0:
            isChecked = row0checked
            
        case 1:
            isChecked = row0checked
            
        case 2:
            isChecked = row0checked

        case 3:
            isChecked = row0checked

        default:
            isChecked = row0checked
        }
        
        cell.accessoryType = isChecked ? .checkmark : .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)

        let label = cell.viewWithTag(1000) as! UILabel

        switch indexPath.row % 5 {
        case 0:
            label.text = row0text
        case 1:
            label.text = row1text
        case 2:
            label.text = row2text
        case 3:
            label.text = row3text
        default:
            label.text = row4text
        }
        
        configureCheckmark(for: cell, at: indexPath)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            switch indexPath.row {
            case 0:
                row0checked.toggle()
                cell.accessoryType = row0checked ? .checkmark : .none

            case 1:
                row1checked.toggle()
                cell.accessoryType = row1checked ? .checkmark : .none

            case 2:
                row2checked.toggle()
                cell.accessoryType = row2checked ? .checkmark : .none

            case 3:
                row3checked.toggle()
                cell.accessoryType = row3checked ? .checkmark : .none

            default:
                row4checked.toggle()
                cell.accessoryType = row4checked ? .checkmark : .none
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

