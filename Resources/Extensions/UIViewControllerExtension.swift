//
//  UIViewControllerExtension.swift
//  RealmTimers
//
//  Created by Jason on 6/27/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import UIKit
extension UIViewController {
    /**
     Just returns the initial view controller on a storyboard.
     */
    static func getInstance() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
