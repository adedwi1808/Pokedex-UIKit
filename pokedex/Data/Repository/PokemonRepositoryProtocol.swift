//
//  PokemonRepositoryProtocol.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//


import Foundation
import RxSwift

protocol PokemonRepositoryProtocol {
    func getPokemonList(offset: Int, limit: Int) -> Observable<[Pokemon]>
    func getPokemonDetail(name: String) -> Observable<PokemonDetail>
}
