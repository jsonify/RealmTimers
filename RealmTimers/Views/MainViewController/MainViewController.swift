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
    var minRowHeight: CGFloat = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        realm = try! Realm()
        
        minRowHeight = 50.0
        
        setGradientToTableView(tableView: tableView, UIColor(red:0.00, green:0.57, blue:0.85, alpha:1.0), UIColor(red:0.40, green:0.00, blue:0.80, alpha:1.0))
        #if DEVELOPMENT
        testVCButton.isHidden = false
        deleteTimersButton.isHidden = false
        #else
        testVCButton.isHidden = true
        deleteTimersButton.isHidden = true
        #endif
    }
    
    func setGradientToTableView(tableView: UITableView, _ topColor:UIColor, _ bottomColor:UIColor) {

        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]


        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = tableView.bounds
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
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
        let tHeight = tableView.frame.height
        if (timerItem.count > 1) {
            let temp = tHeight / CGFloat(timerItem.count)
            return temp > minRowHeight ? temp : minRowHeight
        } else {
            return tHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainCell
        let item = timerItem[indexPath.row]
        cell.timerNameLabel.text = item.timerName
        cell.nameLabel.text = "\(formatTime(date: item.timerTime))"
        cell.preFireLabel.text = "\(item.preFireDuration) min"
        cell.preFireStyle.text = "\(item.preFireStyle)"

        
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
