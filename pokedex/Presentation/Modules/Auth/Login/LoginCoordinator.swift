//
//  LoginCoordinator.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 03/11/25.
//

import UIKit

final class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    var registerCoordinator: RegisterCoordinator?
    var onLoginFinished: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let authRepository = AuthRepository()
        let viewModel = LoginViewModel(authRepository: authRepository)
        let loginVC = LoginViewController(viewModel: viewModel)
        
        loginVC.onLoginSuccess = { [weak self] in
            self?.onLoginFinished?()
        }
        
        loginVC.onRegisterTap = { [weak self] in
            self?.startRegisterCoordinator()
        }
        
        navigationController.setViewControllers([loginVC], animated: false)
    }
    
    private func startRegisterCoordinator() {
        let authRepository = AuthRepository()
        let coordinator = RegisterCoordinator(
            navigationController: navigationController,
            authRepository: authRepository
        )
        
        coordinator.onRegisterFinished = { [weak self] in
            self?.navigationController.popViewController(animated: true)
            self?.registerCoordinator = nil
        }
        
        self.registerCoordinator = coordinator
        coordinator.start()
    }
}

