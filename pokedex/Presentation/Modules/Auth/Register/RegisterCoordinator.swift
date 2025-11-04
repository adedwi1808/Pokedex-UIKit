//
//  RegisterCoordinator.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let authRepository: AuthRepositoryProtocol
    
    var onRegisterFinished: (() -> Void)?
    
    init(navigationController: UINavigationController, authRepository: AuthRepositoryProtocol) {
        self.navigationController = navigationController
        self.authRepository = authRepository
    }
    
    func start() {
        let viewModel = RegisterViewModel(authRepository: authRepository)
        let registerVC = RegisterViewController(viewModel: viewModel)
        
        registerVC.onRegisterSuccess = { [weak self] in
            self?.showSuccessAlertAndFinish()
        }
        
        registerVC.onLoginTap = { [weak self] in
            self?.onRegisterFinished?()
        }
        
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    private func showSuccessAlertAndFinish() {
        let alert = UIAlertController(
            title: "Sukses",
            message: "Registrasi berhasil. Silakan login.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.onRegisterFinished?()
        }))
        navigationController.topViewController?.present(alert, animated: true)
    }
}
