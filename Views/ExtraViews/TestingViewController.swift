//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Jason Rueckert on 8/12/19.
//  Copyright © 2019 Jason Rueckert. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataTimer.shared.check()
        showButtons()
        }

    func showButtons() {
        let closeViewButton: UIButton = UIButton(frame: CGRect(x: view.frame.size.width - 110, y: view.frame.size.height - 100, width: 100, height: 50))
        closeViewButton.layer.cornerRadius = 10
        closeViewButton.backgroundColor = .black
        closeViewButton.setTitle("Close", for: .normal)
        closeViewButton.addTarget(self, action:#selector(closeView), for: .touchUpInside)
        self.view.addSubview(closeViewButton)
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
}




