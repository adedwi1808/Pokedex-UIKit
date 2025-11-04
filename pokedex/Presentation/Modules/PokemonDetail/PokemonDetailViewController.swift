//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher
import MBProgressHUD
import RxCocoa

final class PokemonDetailViewController: UIViewController {
    private let contentView = PokemonDetailView()
    
    private let viewModel: PokemonDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: PokemonDetailViewModel) {
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
        navigationItem.largeTitleDisplayMode = .never
        
        bindViewModel()
        viewModel.viewDidLoad.accept(())
    }
    
    private func bindViewModel() {
        viewModel.name
            .asDriver()
            .drive(contentView.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.abilities
            .asDriver()
            .map { $0.map { "• \($0.capitalized)" }.joined(separator: "\n") }
            .drive(contentView.abilitiesValueLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.imageURL
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] url in
                self?.contentView.pokemonImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(systemName: "circle.dotted")
                )
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .asDriver()
            .drive(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                } else {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.showError
            .asDriver(onErrorJustReturn: "Error")
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
}
