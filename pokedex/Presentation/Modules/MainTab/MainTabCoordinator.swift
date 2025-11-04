//
//  MainTabCoordinator.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import XLPagerTabStrip

final class MainTabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var homeCoordinator: HomeCoordinator?
    var profileCoordinator: ProfileCoordinator?
    
    var onLogoutTapped: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let pagerVC = MainPagerViewController()
        
        let homeNav = UINavigationController()
        homeNav.navigationBar.prefersLargeTitles = true
        let homeCoordinator = HomeCoordinator(navigationController: homeNav)
        homeCoordinator.start()
        self.homeCoordinator = homeCoordinator
        
        let profileNav = UINavigationController()
        profileNav.navigationBar.prefersLargeTitles = true
        let profileCoordinator = ProfileCoordinator(navigationController: profileNav)
        profileCoordinator.start()
        self.profileCoordinator = profileCoordinator
        profileCoordinator.onLogoutTapped = { [weak self] in
            self?.onLogoutTapped?()
        }
        
        pagerVC.tabViewControllers = [
            homeCoordinator.navigationController,
            profileCoordinator.navigationController
        ]
        
        
        navigationController.setViewControllers([pagerVC], animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}


