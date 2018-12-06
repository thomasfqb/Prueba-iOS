//
//  LoginViewModel.swift
//  Prueba
//
//  Created by Thomas Fauquemberg on 06/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import Foundation

enum formError {
    case passwordTooShort, invalidEmail
}


class LoginViewModel {
    
    var email: String? = "" {
        didSet {
            checkFormValidity()
        }
    }
    
    var password: String? = "" {
        didSet {
            checkFormValidity()
        }
    }
    
    var isFormValidObserver: ((Bool, formError?) -> ())?
    
    fileprivate func checkFormValidity() {
        
        if email?.count == 0, password?.count == 0 {
            isFormValidObserver?(false, nil)
            return
        }
        
        if let email = email, !isValidEmail(string: email) {
            isFormValidObserver?(false, .invalidEmail)
            return
        }
        
        if let password = password, password.count < 8, password.count > 0 {
            isFormValidObserver?(false, .passwordTooShort)
            return
        }
        
        if let password = password, password.count == 0 {
            isFormValidObserver?(false, nil)
            return
        }
        
        isFormValidObserver?(true, nil)
        
    }
    
    func isValidEmail(string :String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: string)
    }
    
}
