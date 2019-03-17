//
//  CategoryViewController.swift
//  ToDoApp
//
//  Created by Vidya Muniraju on 3/16/19.
//  Copyright © 2019 Vidya Muniraju. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        

    }

    // MARK: - Table view data source

  

    // MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new category"
            
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //nil coalescing operator
        return categories?.count ?? 1
        
    }
        
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categoies Added Yet"
        
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    //MARK: - Delete Data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
        
            do {
                try self.realm.write {
                self.realm.delete(categoryForDeletion)
                }
            }
            catch {
                print("Error deleting category \(error)")
            }
        
        }
    }
    
    
    
}

//MARK: - Swipe Cell Delegate Methods

