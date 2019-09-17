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
    
    @IBOutlet weak var testVCButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTimerButton: UIButton!
    @IBOutlet weak var deleteTimersButton: UIButton!
    var realm: Realm!
    var timerIndexToEdit: Int?
    var timerItem: Results<TimerModel>{
        get {
            return realm.objects(TimerModel.self)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        realm = try! Realm()
        
        #if DEVELOPMENT
        testVCButton.isHidden = false
        deleteTimersButton.isHidden = false
        #else
        testVCButton.isHidden = true
        deleteTimersButton.isHidden = true
        #endif
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTimerSegue" {
            let popup = segue.destination as! AddTimerViewController
            popup.doneSaving = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        try! self.realm.write {
            self.realm.deleteAll()
            tableView.reloadData()
        }
    }
}

// Mark:- TableView Functions

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
        cell.timerNameLabel.text = item.timerName
        cell.nameLabel.text = "\(formatTime(date: item.timerTime))"
        cell.preFireLabel.text = "\(item.preFireDuration) min"
        cell.preFireStyle.text = "\(item.preFireStyle)"
        
        let hourString = Int(formatHour(date: item.timerTime))!
        var phase = ""
        switch hourString {
        case let hour where hour < 5:
            phase = "nighttime"
        case 5...8:
            phase = "sunrise"
        case 9...16:
            phase = "daytime"
        case 17...18:
            phase = "sunset"
        case 19...20:
            phase = "dusk"
        case 21...24:
            phase = "nighttime"
        default:
            print("Time does not exist here")
        }
        cell.avatarImage.image = UIImage(named: phase)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Clock") as? ClockViewController {
            vc.timerIndexToEdit = indexPath.row
            present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let timerName = timerItem[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "Delete Waker", message: "Are you sure you want to delete \(timerName.timerName)?", preferredStyle: .alert)
            
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
    
    func formatTime(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func formatHour(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: date)
    }
}
