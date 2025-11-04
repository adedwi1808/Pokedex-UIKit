//
//  LoginView.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import SnapKit

final class LoginView: UIView {
    
    let logoImageView = UIImageView(image: .pokemonLogo)
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let registerLabel = UILabel()
    
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
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        loginButton.backgroundColor = .systemBlue
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 8
        
        let text = NSMutableAttributedString(
            string: "Belum punya akun? ",
            attributes: [.foregroundColor: UIColor.secondaryLabel]
        )
        text.append(NSAttributedString(
            string: "Register",
            attributes: [
                .foregroundColor: UIColor.systemBlue,
                .font: UIFont.boldSystemFont(ofSize: 15)
            ]
        ))
        registerLabel.attributedText = text
        registerLabel.isUserInteractionEnabled = true
        registerLabel.textAlignment = .center
        
        let views = [logoImageView, usernameTextField, passwordTextField, loginButton, registerLabel]
        
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
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(usernameTextField)
            $0.height.equalTo(48)
        }
        
        registerLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
