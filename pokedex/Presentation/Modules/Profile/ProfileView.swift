//
//  ProfileView.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import SnapKit

final class ProfileView: UIView {
    
    let usernameLabel = UILabel()
    let logoutButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        usernameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        usernameLabel.textAlignment = .center
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.tintColor = .white
        logoutButton.layer.cornerRadius = 8
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        addSubview(usernameLabel)
        addSubview(logoutButton)
        
        usernameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        logoutButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(usernameLabel)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(30)
            $0.height.equalTo(48)
        }
    }
}
