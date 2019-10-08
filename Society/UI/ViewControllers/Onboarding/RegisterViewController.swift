//
//  RegisterViewController.swift
//  Society
//
//  Created by Adam Oxley on 05/08/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else {
            return
        }
        
        self.setRegisterButtonState(state: false)
        
        UserRequest.init().register(name: name, email: email, password: password) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(registerTextFieldEdited), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(registerTextFieldEdited), for: .editingChanged)

        setRegisterButtonState(state: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if DEBUG
        nameTextField.text = "Adam"
        emailTextField.text = "adam@adamoxley.uk"
        passwordTextField.text = "password"
        registerButton.isEnabled = true
        #endif
    }
    
    @objc func registerTextFieldEdited() {
        if emailTextField.text!.isValidEmail ||
            emailTextField.text!.isValidUsername && !passwordTextField.text!.isEmpty {
            setRegisterButtonState(state: true)
        } else {
            setRegisterButtonState(state: false)
        }
    }

    func setRegisterButtonState(state: Bool) {
        if state {
            registerButton.setTitleColor(UIColor(named: "society_blue"), for: .normal)
            registerButton.isEnabled = true
        } else {
            registerButton.setTitleColor(UIColor(named: "society_grey"), for: .normal)
            registerButton.isEnabled = false
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            view.endEditing(true)
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}
