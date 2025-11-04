//
//  APIService.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Alamofire
import RxSwift

final class APIService {
    static let shared = APIService()
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    private init() {}
    
    func fetchPokemonList(offset: Int, limit: Int) -> Observable<PokemonList> {
        return Observable.create { observer in
            let url = "\(self.baseURL)pokemon"
            let parameters: [String: Any] = ["offset": offset, "limit": limit]
            
            let request = AF.request(url, method: .get, parameters: parameters)
                .validate()
                .responseDecodable(of: PokemonList.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchPokemonDetail(name: String) -> Observable<PokemonDetail> {
        return Observable.create { observer in
            let url = "\(self.baseURL)pokemon/\(name)"
            
            let request = AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: PokemonDetail.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
