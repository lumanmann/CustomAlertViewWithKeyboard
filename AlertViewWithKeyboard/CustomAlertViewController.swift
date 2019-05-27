//
//  CustomAlertViewController.swift
//  AlertViewWithKeyboard
//
//  Created by Natalie Ng on 2019/5/27.
//  Copyright © 2019 appi. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    let textField1 = CustomTextField()
    let textField2 = CustomTextField()
    let textField3 = CustomTextField()
    let textField4 = CustomTextField()
    let confirmButton = CustomButton(title: "confirm")
    let cancelButton = CustomButton(title: "cancel")
    
    private var cancleHandler: (() -> Void)?
    var originY: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.addTarget(self, action: #selector(confirmClicked), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelclicked), for: .touchUpInside)
        
        view.backgroundColor = .gray
        setupView()
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //unsubscribeFromKeyboardNotifications()
    }
    
    func setupView() {

        let stackView = UIStackView(arrangedSubviews: [textField1,textField2,textField3,textField4])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(confirmButton)
        view.addSubview(cancelButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([confirmButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     confirmButton.heightAnchor.constraint(equalToConstant: 40),
                                     confirmButton.widthAnchor.constraint(equalToConstant: 80),
                                     confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)])
        
        NSLayoutConstraint.activate([cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     cancelButton.heightAnchor.constraint(equalToConstant: 40),
                                     cancelButton.widthAnchor.constraint(equalToConstant: 80),
                                     cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)])
            
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 10),
                                     stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                                     stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)])
    }
    
    func setActionHandler(handler: @escaping () -> Void) {
        cancleHandler = handler
    }
    
    @objc func confirmClicked() {
        
        cancleHandler?()
        
    }
    
    
    @objc func cancelclicked() {
        cancleHandler?()
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       
        
    }
    
    // UnSubcribe keyboard
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    // Show keyboard
    @objc func keyboardWillShow(_ notification:Notification) {
        if originY == nil {
           
            originY = view.frame.origin.y
            view.frame.origin.y -= getKeyboardHeight(notification)
            
        }
        
    }
    
 
    
    // Keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        return keyboardSize.cgRectValue.height
    }
    

   
}

extension CustomAlertViewController: UITextFieldDelegate {
  
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField1.isFirstResponder {
            textField2.becomeFirstResponder()
            return true
        }
        
        if textField2.isFirstResponder {
            textField3.becomeFirstResponder()
            return true
        }
        
        if textField3.isFirstResponder {
            textField4.becomeFirstResponder()
            return true
        }
        
        if textField4.isFirstResponder {
            view.endEditing(true)
            if originY != nil {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               options: [.curveEaseInOut ],
                               animations: {
                                self.view.frame.origin.y = self.originY!
                },
                               completion: { _ in
                                self.originY = nil
                })
                
                
            }
        }
        return true
    }
}
