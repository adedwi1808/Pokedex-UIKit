//
//  HomeCoordinator.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let apiService = APIService.shared
        let repository = PokemonRepositoryImpl(apiService: apiService)
        let getListUseCase = GetPokemonListUseCase(repository: repository)
        let getDetailUseCase = GetPokemonDetailUseCase(repository: repository)
        
        let viewModel = HomeViewModel(
            getListUseCase: getListUseCase,
            getDetailUseCase: getDetailUseCase
        )
        let homeVC = HomeViewController(viewModel: viewModel)
        
        viewModel.onPokemonSelected = { [weak self] pokemonName in
            self?.showDetail(pokemonName: pokemonName)
        }
        
        navigationController.setViewControllers([homeVC], animated: false)
    }
    
    func getRootViewController() -> UIViewController {
        return navigationController
    }
    
    func showDetail(pokemonName: String) {
        let repository = PokemonRepositoryImpl(apiService: APIService.shared)
        let getDetailUseCase = GetPokemonDetailUseCase(repository: repository)
        
        let viewModel = PokemonDetailViewModel(
            pokemonName: pokemonName,
            getDetailUseCase: getDetailUseCase
        )
        
        let detailVC = PokemonDetailViewController(viewModel: viewModel)
        
        DispatchQueue.main.async {
            self.navigationController.pushViewController(detailVC, animated: true)
        }
    }
}
