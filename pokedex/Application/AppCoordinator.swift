//
//  AppCoordinator.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 03/11/25.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let window: UIWindow
    
    private var loginCoordinator: LoginCoordinator?
    private var mainTabBarCoordinator: MainTabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        if UserDefaults.isLoggedIn {
            showMainApp()
        } else {
            showLogin()
        }
    }
    
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.onLoginFinished = { [weak self] in
            self?.loginCoordinator = nil
            self?.showMainApp()
        }
        self.loginCoordinator = loginCoordinator
        loginCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func showMainApp() {
        let mainTabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        
        mainTabBarCoordinator.onLogoutTapped = { [weak self] in
            self?.handleLogout()
        }
        
        self.mainTabBarCoordinator = mainTabBarCoordinator
        mainTabBarCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func handleLogout() {
        UserDefaults.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "loggedInUsername")
        
        self.mainTabBarCoordinator = nil
        
        showLogin()
    }
}
