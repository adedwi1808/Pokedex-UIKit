//
//  HomeViewModel.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    private let getListUseCase: GetPokemonListUseCase
    private let getDetailUseCase: GetPokemonDetailUseCase
    private let disposeBag = DisposeBag()
    
    var onPokemonSelected: ((String) -> Void)?
    
    let viewDidLoad = PublishRelay<Void>()
    let loadNextPage = PublishRelay<Void>()
    let itemSelected = PublishRelay<Pokemon>()
    let searchTapped = PublishRelay<String>()
    
    let pokemonList = BehaviorRelay<[Pokemon]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let showError = PublishRelay<String>()
    
    private var currentOffset = 0
    private let limit = 10 //
    private var canLoadMore = true
    
    init(getListUseCase: GetPokemonListUseCase, getDetailUseCase: GetPokemonDetailUseCase) {
        self.getListUseCase = getListUseCase
        self.getDetailUseCase = getDetailUseCase
        
        bindInputs()
    }
    
    private func bindInputs() {
        let loadTrigger = Observable.merge(
            viewDidLoad.map { _ in 0 },
            loadNextPage.map { _ in self.currentOffset }
        )
            .filter { _ in self.canLoadMore }
        
        loadTrigger
            .flatMapLatest { [weak self] offset -> Observable<[Pokemon]> in
                guard let self = self else { return .empty() }
                self.isLoading.accept(true)
                return self.getListUseCase.execute(offset: offset, limit: self.limit)
                    .catch { [weak self] error in
                        self?.showError.accept(error.localizedDescription)
                        return .empty()
                    }
                    .do(onDispose: {
                        self.isLoading.accept(false)
                    })
            }
            .subscribe(onNext: { [weak self] newPokemon in
                guard let self = self else { return }
                
                if newPokemon.isEmpty {
                    self.canLoadMore = false
                } else {
                    var currentList = self.pokemonList.value
                    currentList.append(contentsOf: newPokemon)
                    self.pokemonList.accept(currentList)
                    self.currentOffset += self.limit
                }
            })
            .disposed(by: disposeBag)
        
        itemSelected
            .map { $0.name }
            .subscribe(onNext: { [weak self] name in
                self?.onPokemonSelected?(name)
            })
            .disposed(by: disposeBag)
        
        searchTapped
            .filter { !$0.isEmpty }
            .flatMapLatest { [weak self] name -> Observable<PokemonDetail> in
                guard let self = self else { return .empty() }
                self.isLoading.accept(true)
                return self.getDetailUseCase.execute(name: name)
                    .catch { [weak self] error in
                        self?.showError.accept("Pokemon tidak ditemukan")
                        return .empty()
                    }
                    .do(onDispose: {
                        self.isLoading.accept(false)
                    })
            }
            .subscribe(onNext: { [weak self] pokemonDetail in
                self?.onPokemonSelected?(pokemonDetail.name)
            })
            .disposed(by: disposeBag)
    }
}
