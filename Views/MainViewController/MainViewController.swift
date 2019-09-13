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
    @IBOutlet weak var settingsButton: AppUIButton!
    @IBOutlet weak var newTimerButton: UIButton!
    @IBOutlet weak var deleteTimersButton: UIButton!
    @IBOutlet weak var menuView: UIViewX!
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
    
    fileprivate func setupDevButtons() {
        let testVCButton: UIButton = UIButton(frame: CGRect(x: 20, y: 400, width: 100, height: 50))
        testVCButton.backgroundColor = .black
        testVCButton.setTitle("Test VC", for: .normal)
        testVCButton.addTarget(self, action:#selector(goToTestVC), for: .touchUpInside)
        self.view.addSubview(testVCButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        realm = try! Realm()
        menuConfigure()
        
        #if DEVELOPMENT
        testVCButton.isHidden = false
        deleteTimersButton.isHidden = false
        #else
        testVCButton.isHidden = true
        deleteTimersButton.isHidden = true
        #endif
    }
    
    @objc func goToTestVC() {
        print("Go to goToTestVC")
    }
    
    func menuConfigure() {
        closeMenu()
    }
    @IBAction func menuTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
            } else {
                self.menuView.transform = .identity
            }
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.menuView.transform == .identity {
                self.settingsButton.transform = .identity
                self.newTimerButton.transform = .identity
                self.deleteTimersButton.transform = .identity
            } else {
                
            }
        })
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    fileprivate func closeMenu() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//            self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//            self.settingsButton.transform = CGAffineTransform(translationX: 0, y: 15)
            self.newTimerButton.transform = CGAffineTransform(translationX: 11, y: 11)
            self.deleteTimersButton.transform = CGAffineTransform(translationX: 15, y: 0)
        })
    }
    
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
        
        // Day/Night Phase Avatar
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
    
    // TODO: V2.1 Future feature that allows to edit timer:
    //    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //        let timerName = timerItem[indexPath.row]
    //        let edit = UIContextualAction(style: .normal, title: "") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
    //            print("\(self.realm.objects(TimerModel.self))")
    ////            self.realm.objects(TimerModel.self)
    ////            self.timerIndexToEdit = realm.objects(timerItem.self)
    //            try! self.realm.write {
    //                self.realm?.add(timerItem, value: [timerName: "damn"], update: .modified)
    //
    ////                self.realm?.create(TimerModel.self, value: [timerName: "damn"], update: .modified)
    //            }
    //            //            timerName.timerName = "Hello"
    ////            self.timerItem[indexPath.row].timerName = "hello"
    //            self.performSegue(withIdentifier: "toAddTimerSegue", sender: nil)
    //            actionPerformed(true)
    //        }
    //        edit.image = #imageLiteral(resourceName: "settings")
    //        edit.backgroundColor = Theme.edit
    //        return UISwipeActionsConfiguration(actions: [edit])
    //    }
    
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
