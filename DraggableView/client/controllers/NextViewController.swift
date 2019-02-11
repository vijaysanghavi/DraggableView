//
//  NextViewController.swift
//  DraggableView
//
//  Created by Zycus on 01/02/19.
//  Copyright © 2019 VJ. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    var rootViewController: ViewController?
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .darkGray
        
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(NextViewController.dismissButtonTapped), for: .touchUpInside)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[button]", options: [], metrics: nil, views: ["button": button]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[button]", options: [], metrics: nil, views: ["button": button]))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        button.removeFromSuperview()
    }
    
    @objc func dismissButtonTapped(){
        rootViewController?.disableInteractivePlayerTrasitioning = true
        self.dismiss(animated: true) {
            [unowned self] in
            self.rootViewController?.disableInteractivePlayerTrasitioning = false
        }
    }
    
}
