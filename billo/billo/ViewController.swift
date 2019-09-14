//
//  ViewController.swift
//  billo
//
//  Created by Denis Nefedov on 14.09.2019.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    let logoImage: UIImageView = {
        let image = UIImage(named: "logo")
        let view = UIImageView(image: image?.withRenderingMode(.alwaysOriginal))
        return view
    }()
    
    let emailTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    @objc func handleTextInputChange() {
        
        let emailIsValid = emailTextField.text?.count ?? 0 > 0 && emailTextField.text?.contains("@") ?? false == true && passwordTextField.text?.count ?? 0 > 6 && phoneTextField.text?.count ?? 0 > 0
        
        if emailIsValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    
    let phoneTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Phone number"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
        
    let walletTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Wallet number"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let signupButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.isEnabled = false
        
        return button
    }()
    
    @objc func handleSignup() {
        guard let email = emailTextField.text, email.count > 0, email.contains("@") else {return}
        guard let password = passwordTextField.text, password.count > 0 else {return}
        guard let wallet = walletTextField.text, wallet.count > 0 else {return}
        guard let phone = phoneTextField.text, phone.count > 0 else {return}
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            
            print("Succses: with", result?.user.uid ?? "")
            
            // saving data to database
            let meta = [["email":email], ["phone":phone], ["wallet":wallet]]
            guard let uid = result?.user.uid else { return }
            let values = [uid:meta]
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let error = err {
                    print("Failed to save user info into DB", error)
                    return
                } else {
                    print("Successfully saved user info into DB")
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneTextField.delegate = self

        view.addSubview(logoImage)
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        logoImage.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        
        setupFields()
    }
    
    fileprivate func setupFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, phoneTextField, walletTextField, passwordTextField, signupButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
                
        view.addSubview(stackView)
        
        
        stackView.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == phoneTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }

}


