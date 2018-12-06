//
//  ViewController.swift
//  Prueba
//
//  Created by Thomas Fauquemberg on 06/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK:- Config
    
    let enableLoginButtonColor: UIColor = .white
    let disableLoginButtonColor: UIColor = #colorLiteral(red: 0.5860589378, green: 0.5860589378, blue: 0.5860589378, alpha: 1)
    let placeholderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

    
    let titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Login to discover Marvel movies."
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont.systemFont(ofSize: 42, weight: .heavy)
        return lbl
    }()
    
    lazy var emailTextField: UITextField = {
       let tf = LoginFormTextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email",
                                                      attributes: [NSAttributedString.Key.foregroundColor: placeholderColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = LoginFormTextField()
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Password",
                                                   attributes: [NSAttributedString.Key.foregroundColor: placeholderColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var loginButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.setTitleColor(.gray, for: UIControl.State.normal)
        btn.backgroundColor = disableLoginButtonColor
        btn.layer.cornerRadius = 25
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func handleLogin() {
        handleTapToDismiss()
        isLoggedIn = true
        self.dismiss(animated: true, completion: nil)
    }
    
    let errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    @objc func handleTextChange(textField: UITextField) {
        if textField == emailTextField {
            loginViewModel.email = textField.text
        } else {
            loginViewModel.password = textField.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupLoginViewModelObserver()
        setupKeyboardObserver()
        setupTapToDismiss()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    let loginViewModel = LoginViewModel()
    
    fileprivate func setupLoginViewModelObserver() {
        loginViewModel.isFormValidObserver = { [unowned self] (isFormValid, error) in
            if isFormValid {
                self.loginButton.isEnabled = true
                self.loginButton.backgroundColor = self.enableLoginButtonColor
                self.errorLabel.text = ""
                return
            }
            
            self.loginButton.isEnabled = false
            self.loginButton.backgroundColor = self.disableLoginButtonColor
            self.errorLabel.text = ""
            
            guard let error = error else { return }
            
            switch error {
            case .invalidEmail:
                self.errorLabel.text = "⚠ Invalid email format"
            default:
                self.errorLabel.text = "⚠ Your password should be at least 8 caracters long"
            }
            
        }
    }
    
    // MARK:- Keyboard Management
    
    fileprivate func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = value.cgRectValue.height
        let spaceToBottom = view.frame.height - inputStackView.frame.origin.y - inputStackView.frame.height
        let difference = keyboardHeight - spaceToBottom
        if difference > 0 {
            self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
        }
        
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    fileprivate func setupTapToDismiss() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapToDismiss)))
    }
    
    @objc fileprivate func handleTapToDismiss() {
        self.view.endEditing(true)
    }
    
    // MARK:- UI
    
    lazy var inputStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
            loginButton,
            errorLabel
        ])
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    fileprivate func setupLayout() {
        
        view.addSubview(inputStackView)
        
        let spacing: CGFloat = 8
        inputStackView.spacing = spacing
        
        let numberOfViews: CGFloat = CGFloat(inputStackView.arrangedSubviews.count)
        let inputStackViewHeight = numberOfViews * 50 + spacing * (numberOfViews-1)
        
        inputStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: inputStackViewHeight))
        inputStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: inputStackView.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 12, left: 18, bottom: 12, right: 18))
        //titleLabel.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor).isActive = true
    }

    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9058823529, green: 0.09411764706, blue: 0.1725490196, alpha: 1).cgColor
        let bottomColor = #colorLiteral(red: 0.409505248, green: 0.04664861354, blue: 0.08396342968, alpha: 1).cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0,1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
}

