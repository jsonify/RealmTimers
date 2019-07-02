//
//  ViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/26/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import RealmSwift
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var realm: Realm!
    
    var timerItem: Results<TimerModel>{
        get {
            return realm.objects(TimerModel.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        realm = try! Realm()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTimerSegue" {
            let popup = segue.destination as! AddTimerViewController
            popup.doneSaving = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "New ToDo", message: "What do you want to do?", preferredStyle: .alert)
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Create new ToDo item"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (UIAlertAction) -> Void in
            let timerItemTextField = (alert.textFields?.first)! as UITextField
            
            let newTimerItem = TimerModel()
            newTimerItem.name = timerItemTextField.text!
//            newToDoListItem.done = false
            
            try! self.realm.write {
                self.realm.add(newTimerItem)
                
                self.tableView.insertRows(at: [IndexPath.init(row: self.timerItem.count-1, section: 0)], with: .automatic)
            }
        }))
        
        present(alert, animated: true)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainCell
        let item = timerItem[indexPath.row]
        
//        cell.textLabel!.text = item.name
        cell.nameLabel.text = item.name
        cell.preFireLabel.text = "\(item.preFireDuration)"
        cell.fireDuration.text = "\(item.fireDuration)"
//        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = timerItem[indexPath.row]
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Clock") as? ClockViewController {
//             vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
//         MAKE THIS FOR EDITING THE TIMER DETAILS
//        try! realm.write {
//            item.done = !item.done
//        }
//        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = timerItem[indexPath.row]
            
            try! realm.write {
                realm.delete(item)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
