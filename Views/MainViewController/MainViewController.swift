//
//  ViewController.swift
//  RealmTimers
//
//  Created by Jason on 6/26/19.
//  Copyright © 2019 Jason. All rights reserved.
//
import SwiftDate
import RealmSwift
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var realm: Realm!
    var timerIndexToEdit: Int?
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
//        else if segue.identifier == "toClockSegue" {
//            let timer = segue.destination as! ClockViewController
//            timer.timerIndexToEdit = self.timerIndexToEdit
//        }
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
        
        cell.nameLabel.text = item.name.toString()
        cell.preFireLabel.text = "\(item.preFireDuration) minutes"
        cell.fireDuration.text = "\(item.fireDuration) minutes"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Clock") as? ClockViewController {
            vc.timerIndexToEdit = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // TODO: V2.1 Future feature that allows to edit timer:
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIContextualAction(style: .normal, title: "") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
//            self.timerIndexToEdit = indexPath.row
//            self.performSegue(withIdentifier: "toAddTimerSegue", sender: nil)
//            actionPerformed(true)
//        }
//        edit.image = #imageLiteral(resourceName: "pencil")
//        edit.backgroundColor = Theme.edit
//        return UISwipeActionsConfiguration(actions: [edit])
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let timerName = timerItem[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete \(timerName.name)?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                // Perform delete
                try! self.realm.write {
                    self.realm.delete(timerName)
                }
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }))
            
            self.present(alert, animated: true)
            
        }
        delete.image = #imageLiteral(resourceName: "delete")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
