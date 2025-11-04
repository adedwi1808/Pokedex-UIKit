//
//  PokemonObject.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//


import Foundation
import RealmSwift

final class PokemonObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var url: String

    convenience init(pokemon: Pokemon) {
        self.init()
        self.name = pokemon.name
        self.url = pokemon.url
        self.id = Int(pokemon.url.split(separator: "/").last.map(String.init) ?? "0") ?? 0
    }
}
