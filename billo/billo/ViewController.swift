//
//  ViewController.swift
//  billo
//
//  Created by Denis Nefedov on 14.09.2019.
//  Copyright © 2019 X. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let logoImage: UIImageView = {
        let image = UIImage(named: "logo")
        let view = UIImageView(image: image?.withRenderingMode(.alwaysOriginal))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Phone number"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let walletTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Wallet number"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let signupButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(logoImage)
        logoImage.heightAnchor.constraint(equalToConstant: 140).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        setupFields()
    }
    
    fileprivate func setupFields() {
        let stackView = UIStackView(arrangedSubviews: [phoneTextField, walletTextField, passwordTextField, signupButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate(
                [stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
                stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
                stackView.heightAnchor.constraint(equalToConstant: 200)]
            )
    }

}

