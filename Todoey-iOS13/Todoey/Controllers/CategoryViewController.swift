//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Heang Ly on 6/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()

    var categoryArray: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

    func saveCategory(newCategory: Category? = nil) {
        if let newCategory = newCategory, !newCategory.name.isEmpty {            
            do {
                try realm.write {
                    realm.add(newCategory)
                }
            } catch {
                print("Error saving category, \(error)")
            }
            
            tableView.reloadData()
        }
    }


    func loadCategory() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }


    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }

    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let ac = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        ac.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textField = alertTextField
        }

        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.saveCategory(newCategory: newCategory)
        }

        ac.addAction(action)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(ac, animated: true, completion: nil)
    }


//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
////            context.delete(categoryArray[indexPath.row])
////            self.categoryArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            saveCategory()
//        }
//    }





}
