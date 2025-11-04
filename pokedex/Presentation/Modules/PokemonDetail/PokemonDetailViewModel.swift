//
//  PokemonDetailViewModel.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation
import RxSwift
import RxCocoa

final class PokemonDetailViewModel {
    
    private let pokemonName: String
    private let getDetailUseCase: GetPokemonDetailUseCase
    private let disposeBag = DisposeBag()
    
    let viewDidLoad = PublishRelay<Void>()
    
    let pokemonDetail = BehaviorRelay<PokemonDetail?>(value: nil)
    let abilities = BehaviorRelay<[String]>(value: [])
    let name = BehaviorRelay<String>(value: "")
    let imageURL = BehaviorRelay<URL?>(value: nil)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let showError = PublishRelay<String>()
    
    init(pokemonName: String, getDetailUseCase: GetPokemonDetailUseCase) {
        self.pokemonName = pokemonName
        self.getDetailUseCase = getDetailUseCase
        
        bindInputs()
    }
    
    private func bindInputs() {
        viewDidLoad
            .flatMapLatest { [weak self] _ -> Observable<PokemonDetail> in
                guard let self = self else { return .empty() }
                self.isLoading.accept(true)
                return self.getDetailUseCase.execute(name: self.pokemonName)
                    .catch { [weak self] error in
                        self?.showError.accept(error.localizedDescription)
                        return .empty()
                    }
                    .do(onDispose: {
                        self.isLoading.accept(false)
                    })
            }
            .subscribe(onNext: { [weak self] detail in
                self?.pokemonDetail.accept(detail)
                
                self?.name.accept(detail.name.capitalized)
                let abilityNames = detail.abilities.map { $0.ability.name }
                self?.abilities.accept(abilityNames)
                
                let url = URL(string: detail.sprites.frontDefault)
                self?.imageURL.accept(url)
            })
            .disposed(by: disposeBag)
    }
}
