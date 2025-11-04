//
//  ProfileViewModel.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileViewModel {
    let username: Driver<String>
    
    init() {
        let storedUsername = UserDefaults.standard.string(forKey: "loggedInUsername") ?? "N/A"
        username = BehaviorRelay<String>(value: storedUsername).asDriver()
    }
}
