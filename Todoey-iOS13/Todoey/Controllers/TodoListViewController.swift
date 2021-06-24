//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()


    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer
        .viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].done.toggle()
        saveItems(newItem: nil)
        tableView.reloadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)


        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.saveItems(newItem: newItem)
        }

        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(itemArray[indexPath.row])
            self.itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveItems(newItem: nil)
        }q
    }

    func saveItems(newItem: Item?) {
        if let newItem = newItem, !newItem.title!.isEmpty {
//            self.itemArray.insert(newItem, at: 0)
            self.itemArray.append(newItem)
        }

        do {
            try context.save()
        } catch {
            print("Error encoding item array, \(error)")
        }

        self.tableView.reloadData()
    }

    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray =  try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
    }
}


