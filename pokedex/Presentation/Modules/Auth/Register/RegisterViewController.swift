//
//  RegisterViewController.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import RxSwift
import RxCocoa

final class RegisterViewController: UIViewController {
    private let contentView = RegisterView()
    private let viewModel: RegisterViewModel
    private let disposeBag = DisposeBag()
    
    var onRegisterSuccess: (() -> Void)?
    var onLoginTap: (() -> Void)?
    
    init(viewModel: RegisterViewModel) {
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
        
        contentView.confirmPasswordTextField.rx.text.orEmpty
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)
        
        contentView.registerButton.rx.tap
            .bind(to: viewModel.registerTap)
            .disposed(by: disposeBag)
        
        viewModel.isRegisterEnabled
            .bind(to: contentView.registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.registerResult
            .subscribe(onNext: { [weak self] success in
                if success {
                    self?.onRegisterSuccess?()
                } else {
                    self?.showErrorAlert()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        contentView.loginLabel.isUserInteractionEnabled = true
        contentView.loginLabel.addGestureRecognizer(tap)
    }
    
    @objc private func loginTapped() {
        onLoginTap?()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Registrasi gagal. Pastikan username belum dipakai dan password cocok.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
