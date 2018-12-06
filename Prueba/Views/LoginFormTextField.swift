//
//  LoginFormTextField.swift
//  Prueba
//
//  Created by Thomas Fauquemberg on 06/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class LoginFormTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .white
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 25
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: 15, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: 15, dy: 0)
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
