//
//  BottomBar.swift
//  DraggableView
//
//  Created by Zycus on 01/02/19.
//  Copyright © 2019 VJ. All rights reserved.
//

import UIKit

class BottomBar: UIView {
    
    static let bottomBarHeight: CGFloat = 50
    var button: UIButton!
    
}

class FakeView: UIView {
    static let fakeBarHeight: CGFloat = 50
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubview(){
        self.backgroundColor = .gray
        
        button = UIButton()
        button.setTitle("Tap or drag me", for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|", options: [], metrics: nil, views: ["button": button]))
    }
}
