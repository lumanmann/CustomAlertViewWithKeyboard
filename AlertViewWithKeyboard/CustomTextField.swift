//
//  CustomTextField.swift
//  AlertViewWithKeyboard
//
//  Created by Natalie Ng on 2019/5/27.
//  Copyright © 2019 appi. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.textColor = .gray
        self.keyboardType = .default
        self.borderStyle = .roundedRect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
