//
//  Pokemon.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation

nonisolated struct PokemonList: Codable, Sendable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

nonisolated struct Pokemon: Codable, Hashable, Sendable {
    let name: String
    let url: String
}

nonisolated struct PokemonDetail: Codable, Sendable {
    let id: Int
    let name: String
    let abilities: [AbilitySlot]
    let sprites: Sprite
}

nonisolated struct AbilitySlot: Codable, Sendable {
    let ability: Ability
}

nonisolated struct Ability: Codable, Sendable {
    let name: String
}

nonisolated struct Sprite: Codable, Sendable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
