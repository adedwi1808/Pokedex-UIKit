//
//  UserObject.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//


import Foundation
import RealmSwift

final class UserObject: Object {
    @Persisted(primaryKey: true) var username: String
    @Persisted var passwordHash: String

    convenience init(username: String, passwordHash: String) {
        self.init()
        self.username = username
        self.passwordHash = passwordHash
    }
}
