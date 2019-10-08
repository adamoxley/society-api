//
//  LogInViewController.swift
//  Society
//
//  Created by Adam Oxley on 28/05/2018.
//  Copyright © 2018 Adam Oxley. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var authButtonStackView: UIStackView!
    
    // MARK: - IBActions
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {

    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        setLoginButtonState(state: false)
        
        UserRequest.init().login(email: email, password: password) { result in
            print(result)
        }
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            setUpProviderLoginView()
        }
        
        hideKeyboardWhenTappedAround()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(loginTextFieldEdited), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(loginTextFieldEdited), for: .editingChanged)

        setLoginButtonState(state: false)
        
        #if DEBUG
        setLoginButtonState(state: true)
        #endif
    }
    
    @objc func loginTextFieldEdited() {
        if emailTextField.text!.isValidEmail || emailTextField.text!.isValidUsername && !passwordTextField.text!.isEmpty {
            setLoginButtonState(state: true)
        } else {
            setLoginButtonState(state: false)
        }
    }

    func setLoginButtonState(state: Bool) {
        if state {
            loginButton.setTitleColor(UIColor(named: "society_blue"), for: .normal)
            loginButton.isEnabled = true
        } else {
            loginButton.setTitleColor(UIColor(named: "society_grey"), for: .normal)
            loginButton.isEnabled = false
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
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

@available(iOS 13.0, *)
extension LoginViewController {
    
    @available(iOS 13.0, *)
    @objc func handleAuthorizationAppleIDButtonPress() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @available(iOS 13.0, *)
    func setUpProviderLoginView() {
        let appleButton = ASAuthorizationAppleIDButton(type: .continue, style: .black)
        appleButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        appleButton.cornerRadius = appleButton.frame.height / 2
        appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        authButtonStackView.addArrangedSubview(appleButton)
    }
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        print("USER: \(appleIDCredential.user)")
        print("EMAIL: \(appleIDCredential.email!)")
        print("FULL NAME: \(appleIDCredential.fullName!)")
        
        guard let passwordCredentials = authorization.credential as? ASPasswordCredential else { return }
        
        print("PASSWORD USER: \(passwordCredentials.user)")
        print("PASSWORD USER: \(passwordCredentials.password)")
    }
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {

    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
