//
//  PokemonRepositoryImpl.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation
import RxSwift
import RealmSwift

final class PokemonRepositoryImpl: PokemonRepositoryProtocol {
    
    private let apiService: APIService
    private var realm: Realm {
        try! Realm()
    }
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getPokemonList(offset: Int, limit: Int) -> Observable<[Pokemon]> {
        let networkObservable = apiService.fetchPokemonList(offset: offset, limit: limit)
            .do(onNext: { [weak self] list in
                // Simpan ke DB setelah fetch
                self?.savePokemonListToDB(list.results)
            })
            .map { $0.results }
        
        let cacheObservable = getPokemonListFromDB(offset: offset, limit: limit)
        
        return networkObservable.catch { _ in cacheObservable }
    }
    
    private func savePokemonListToDB(_ pokemons: [Pokemon]) {
        let realm = self.realm
        try? realm.write {
            for pokemon in pokemons {
                let obj = PokemonObject(pokemon: pokemon)
                realm.add(obj, update: .modified)
            }
        }
    }
    
    private func getPokemonListFromDB(offset: Int, limit: Int) -> Observable<[Pokemon]> {
        return Observable.create { observer in
            let results = self.realm.objects(PokemonObject.self).sorted(byKeyPath: "id")
            let paginatedResults: [PokemonObject]
            if offset < results.count {
                let end = min(offset + limit, results.count)
                paginatedResults = Array(results[offset..<end])
            } else {
                paginatedResults = []
            }
            
            let pokemons = paginatedResults.map { Pokemon(name: $0.name, url: $0.url) }
            
            if pokemons.isEmpty && offset == 0 {
                observer.onError(NSError(domain: "CacheError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Data offline tidak ditemukan."]))
            } else {
                observer.onNext(pokemons)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func getPokemonDetail(name: String) -> Observable<PokemonDetail> {
        let networkObservable = apiService.fetchPokemonDetail(name: name)
            .do(onNext: { [weak self] detail in
                self?.savePokemonDetailToDB(detail)
            })
        
        let cacheObservable = getPokemonDetailFromDB(name: name)
        
        return networkObservable.catch { _ in cacheObservable }
    }
    
    private func savePokemonDetailToDB(_ detail: PokemonDetail) {
        let realm = self.realm
        try? realm.write {
            let obj = PokemonDetailObject(detail: detail)
            realm.add(obj, update: .modified)
        }
    }
    
    private func getPokemonDetailFromDB(name: String) -> Observable<PokemonDetail> {
        return Observable.create { observer in
            if let obj = self.realm.objects(PokemonDetailObject.self).filter("name ==[c] %@", name).first {
                observer.onNext(obj.toPokemonDetail())
                observer.onCompleted()
            } else {
                observer.onError(NSError(domain: "CacheError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Detail offline tidak ditemukan."]))
            }
            
            return Disposables.create()
        }
    }
}
