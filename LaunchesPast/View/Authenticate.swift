//
//  Authenticate.swift
//  LaunchesPast
//
//  Created by Xavier Morales on 22/08/23.
//

import Foundation
import UIKit
import FirebaseAuth

class Authenticate: UIViewController {
    
    lazy var userTextField: UITextField = {
       let userTextField = UITextField()
        
        userTextField.attributedPlaceholder = NSAttributedString(
            string: "User",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        userTextField.font = UIFont.systemFont(ofSize: 20)
        userTextField.borderStyle = UITextField.BorderStyle.roundedRect
        userTextField.backgroundColor = .white
        userTextField.textColor = .black
        userTextField.keyboardType = .emailAddress
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        return userTextField
    }()
    
    lazy var passwordTextField: UITextField = {
       let passwordTextField = UITextField()
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.backgroundColor = .white
        passwordTextField.textColor = .black
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    
    lazy var registerButton: UIButton = {
       let registerButton = UIButton()
        
        registerButton.backgroundColor = .blue
        registerButton.setTitle("Register", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.layer.cornerRadius = 9
        registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        return registerButton
    }()
    
    lazy var loginButton: UIButton = {
       let loginButton = UIButton()
        
        loginButton.backgroundColor = .systemGreen
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 9
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = "Authenticate"
        self.navigationItem.setHidesBackButton(true, animated: true)
        mangeTextField()
    }
    
    func mangeTextField(){
        view.addSubview(userTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            userTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            registerButton.widthAnchor.constraint(equalToConstant: ((self.view.bounds.width) / 2) - 30),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            loginButton.widthAnchor.constraint(equalToConstant: ((self.view.bounds.width) / 2) - 30)
        ])
    }
    
    @objc func registerButtonAction(sender: UIButton!) {
      print("registerButtonAction Button tapped")
        if let email = userTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil {
                    let alertControllerSucess = UIAlertController(title: "Success", message: "Now you can login", preferredStyle: .alert)
                    alertControllerSucess.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertControllerSucess, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "An error ocurred", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    @objc func loginButtonAction(sender: UIButton!) {
      print("loginButtonAction Button tapped")
        if let email = userTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil {
                    let vc = ViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "An error ocurred", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
}
