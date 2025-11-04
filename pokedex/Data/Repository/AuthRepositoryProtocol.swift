//
//  AuthRepositoryProtocol.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//


import Foundation
import RealmSwift
import CryptoKit

protocol AuthRepositoryProtocol {
    func login(username: String, password: String) -> Bool
    func register(username: String, password: String) -> Bool
}

final class AuthRepository: AuthRepositoryProtocol {
    
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch let error {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    private func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let digest = SHA256.hash(data: data)
        return digest.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func login(username: String, password: String) -> Bool {
        guard let user = realm.object(ofType: UserObject.self, forPrimaryKey: username) else {
            return false
        }
        
        let passwordHash = hashPassword(password)
        return user.passwordHash == passwordHash
    }
    
    func register(username: String, password: String) -> Bool {
        if realm.object(ofType: UserObject.self, forPrimaryKey: username) != nil {
            return false
        }
        
        let passwordHash = hashPassword(password)
        
        let newUser = UserObject(username: username, passwordHash: passwordHash)
        
        do {
            try realm.write {
                realm.add(newUser)
            }
            return true
        } catch {
            print("Failed to register user: \(error.localizedDescription)")
            return false
        }
    }
}
