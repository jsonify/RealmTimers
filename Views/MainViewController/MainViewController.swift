//
//  ViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/26/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import RealmSwift
import UIKit

class MainViewController: UITableViewController {
    
    var realm: Realm!
    var toDoList: Results<ToDoListItem>{
        get {
            return realm.objects(ToDoListItem.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
    }
    
    //MARK - Add DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = toDoList[indexPath.row]
        cell.textLabel!.text = item.name
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = toDoList[indexPath.row]
        
        try! realm.write {
            item.done = !item.done
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = toDoList[indexPath.row]
            
            try! realm.write {
                realm.delete(item)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New ToDo", message: "What do you want to do?", preferredStyle: .alert)
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Create new ToDo item"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (UIAlertAction) -> Void in
            let todoItemTextField = (alert.textFields?.first)! as UITextField
            
            let newToDoListItem = ToDoListItem()
            newToDoListItem.name = todoItemTextField.text!
            newToDoListItem.done = false
            
            try! self.realm.write {
                self.realm.add(newToDoListItem)
                
                self.tableView.insertRows(at: [IndexPath.init(row: self.toDoList.count-1, section: 0)], with: .automatic)
            }
        }))
        
        present(alert, animated: true)
    }
    
}

