//
//  RegisterView.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import SnapKit

final class RegisterView: UIView {
    
    let logoImageView = UIImageView(image: .pokemonLogo)
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let registerButton = UIButton(type: .system)
    let loginLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        logoImageView.contentMode = .scaleAspectFit
        
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.borderStyle = .roundedRect
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        registerButton.backgroundColor = .systemGreen
        registerButton.tintColor = .white
        registerButton.layer.cornerRadius = 8
        
        let text = NSMutableAttributedString(
            string: "Sudah punya akun? ",
            attributes: [.foregroundColor: UIColor.secondaryLabel]
        )
        text.append(NSAttributedString(
            string: "Login",
            attributes: [
                .foregroundColor: UIColor.systemBlue,
                .font: UIFont.boldSystemFont(ofSize: 15)
            ]
        ))
        loginLabel.attributedText = text
        loginLabel.isUserInteractionEnabled = true
        loginLabel.textAlignment = .center
        
        let views = [logoImageView, usernameTextField, passwordTextField, confirmPasswordTextField, registerButton, loginLabel]
        
        for view in views {
            addSubview(view)
        }
        
        layoutUI()
    }
    
    private func layoutUI() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(180)
            $0.height.equalTo(80)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(usernameTextField)
            $0.height.equalTo(44)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(usernameTextField)
            $0.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(usernameTextField)
            $0.height.equalTo(48)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
