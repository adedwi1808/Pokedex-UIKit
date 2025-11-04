//
//  LoginViewController.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 03/11/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    private let contentView = LoginView()
    private let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    var onLoginSuccess: (() -> Void)?
    var onRegisterTap: (() -> Void)?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupActions()
    }
    
    private func bindViewModel() {
        contentView.usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        contentView.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        contentView.loginButton.rx.tap
            .bind(to: viewModel.loginTap)
            .disposed(by: disposeBag)
        
        viewModel.isLoginEnabled
            .bind(to: contentView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.loginResult
            .subscribe(onNext: { [weak self] success in
                if success {
                    self?.onLoginSuccess?()
                } else {
                    self?.showErrorAlert()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(registerTapped))
        contentView.registerLabel.isUserInteractionEnabled = true
        contentView.registerLabel.addGestureRecognizer(tap)
    }
    
    @objc private func registerTapped() {
        onRegisterTap?()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Username atau password salah", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
