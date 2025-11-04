//
//  GetPokemonDetailUseCase.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//


import Foundation
import RxSwift

final class GetPokemonDetailUseCase {
    private let repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(name: String) -> Observable<PokemonDetail> {
        let cleanedName = name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        return repository.getPokemonDetail(name: cleanedName)
    }
}
