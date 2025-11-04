//
//  GetPokemonListUseCase.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//


import Foundation
import RxSwift

final class GetPokemonListUseCase {
    private let repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(offset: Int, limit: Int = 10) -> Observable<[Pokemon]> {
        return repository.getPokemonList(offset: offset, limit: limit)
    }
}
