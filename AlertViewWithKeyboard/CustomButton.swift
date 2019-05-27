//
//  CustomButton.swift
//  AlertViewWithKeyboard
//
//  Created by Natalie Ng on 2019/5/27.
//  Copyright © 2019 appi. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
