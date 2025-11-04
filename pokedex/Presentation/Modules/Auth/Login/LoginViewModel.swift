//
//  LoginViewModel.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel {
    private let authRepository: AuthRepositoryProtocol
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let loginTap = PublishRelay<Void>()
    
    let isLoginEnabled = BehaviorRelay<Bool>(value: false)
    let loginResult = PublishRelay<Bool>()
    
    private let disposeBag = DisposeBag()
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
        setupBindings()
    }
    
    private func setupBindings() {
        Observable
            .combineLatest(username, password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .distinctUntilChanged()
            .bind(to: isLoginEnabled)
            .disposed(by: disposeBag)
        
        loginTap
            .withLatestFrom(Observable.combineLatest(username, password))
            .map { [weak self] username, password in
                guard let self = self else { return false }
                
                let loginSuccess = self.authRepository.login(username: username, password: password)
                
                if loginSuccess {
                    UserDefaults.isLoggedIn = true
                    UserDefaults.standard.set(username, forKey: "loggedInUsername")
                    return true
                } else {
                    return false
                }
            }
            .bind(to: loginResult)
            .disposed(by: disposeBag)
    }
}

