//
//  HomeViewController.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD
import XLPagerTabStrip

final class HomeViewController: UIViewController, IndicatorInfoProvider {
    
    private let contentView = HomeView()
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        bindViewModel()
        viewModel.viewDidLoad.accept(())
    }
    
    private func setupNavigation() {
        navigationItem.searchController = contentView.searchController
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func bindViewModel() {
        viewModel.pokemonList
            .bind(to: contentView.collectionView.rx.items(
                cellIdentifier: PokemonGridCell.identifier,
                cellType: PokemonGridCell.self)
            ) { (row, pokemon, cell) in
                cell.configure(with: pokemon)
            }
            .disposed(by: disposeBag)
        
        contentView.collectionView.rx.modelSelected(Pokemon.self)
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        contentView.collectionView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] (_, indexPath) in
                guard let self = self else { return }
                let lastItem = self.contentView.collectionView.numberOfItems(inSection: 0) - 1
                
                if indexPath.item == lastItem {
                    self.viewModel.loadNextPage.accept(())
                }
            })
            .disposed(by: disposeBag)
        
        contentView.searchController.searchBar.rx.searchButtonClicked
            .map { self.contentView.searchController.searchBar.text ?? "" }
            .bind(to: viewModel.searchTapped)
            .disposed(by: disposeBag)
        
        viewModel.isLoading.asDriver()
            .drive(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.showError.asDriver(onErrorJustReturn: "Error")
            .drive(onNext: { [weak self] message in
                self?.showErrorAlert(message: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Home")
    }
}
