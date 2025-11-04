//
//  ProfileCoordinator.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController
    var onLogoutTapped: (() -> Void)?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ProfileViewModel()
        let profileVC = ProfileViewController(viewModel: viewModel)
        profileVC.onLogout = { [weak self] in
            self?.onLogoutTapped?()
        }
        navigationController.setViewControllers([profileVC], animated: false)
    }
    
    func getRootViewController() -> UIViewController {
        return navigationController
    }
}
