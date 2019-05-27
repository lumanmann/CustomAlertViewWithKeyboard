//
//  ViewController.swift
//  AlertViewWithKeyboard
//
//  Created by Natalie Ng on 2019/5/27.
//  Copyright © 2019 appi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    var currentVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(popAlert), for: .touchUpInside)
    }

    @objc func popAlert() {
        let alertView = CustomAlertViewController()
        self.addChild(alertView)
        alertView.view.frame = CGRect(x: 0, y: self.view.frame.maxY-self.view.frame.height * 0.3, width: self.view.frame.width, height: self.view.frame.height * 0.3)
        
        alertView.setActionHandler {
            self.currentVC.willMove(toParent: nil)
            self.currentVC.removeFromParent()
            self.currentVC.view.removeFromSuperview()
        }
        self.view.addSubview(alertView.view)
        
        alertView.didMove(toParent: self)
        currentVC = alertView
    }
}

