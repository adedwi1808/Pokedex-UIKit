//
//  PokemonDetailObject.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation
import RealmSwift

final class PokemonDetailObject: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var frontDefaultSpriteUrl: String
    @Persisted var abilities = List<String>()
    
    convenience init(detail: PokemonDetail) {
        self.init()
        self.id = detail.id
        self.name = detail.name
        self.frontDefaultSpriteUrl = detail.sprites.frontDefault
        
        let abilityNames = detail.abilities.map { $0.ability.name }
        self.abilities.append(objectsIn: abilityNames)
    }
    
    func toPokemonDetail() -> PokemonDetail {
        let abilitySlots = Array(self.abilities.map { name in
            AbilitySlot(ability: Ability(name: name))
        })
        
        let sprite = Sprite(frontDefault: self.frontDefaultSpriteUrl)
        
        return PokemonDetail(id: self.id, name: self.name, abilities: abilitySlots, sprites: sprite)
    }
}
