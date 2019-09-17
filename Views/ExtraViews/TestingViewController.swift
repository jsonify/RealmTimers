//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Jason Rueckert on 8/12/19.
//  Copyright © 2019 Jason Rueckert. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {
    
    var preFireTime: Int!
    
    let presentImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "present"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showButtons()
        showPresent()
        }
    
    fileprivate func showPresent() {
        view.addSubview(presentImageView)
        presentImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        presentImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        presentImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    fileprivate func showButtons() {
        let closeViewButton: UIButton = UIButton(frame: CGRect(x: view.frame.size.width - 110, y: view.frame.size.height - 100, width: 100, height: 50))
        closeViewButton.layer.cornerRadius = 10
        closeViewButton.backgroundColor = .black
        closeViewButton.setTitle("Close", for: .normal)
        closeViewButton.addTarget(self, action:#selector(closeView), for: .touchUpInside)
        self.view.addSubview(closeViewButton)
    }
    
    @objc fileprivate func closeView() {
        dismiss(animated: true, completion: nil)
    }
}




