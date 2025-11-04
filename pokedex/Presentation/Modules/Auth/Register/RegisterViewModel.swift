//
//  RegisterViewModel.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import Foundation
import RxSwift
import RxCocoa

final class RegisterViewModel {
    private let authRepository: AuthRepositoryProtocol
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let confirmPassword = BehaviorRelay<String>(value: "")
    let registerTap = PublishRelay<Void>()
    
    let isRegisterEnabled = BehaviorRelay<Bool>(value: false)
    let registerResult = PublishRelay<Bool>()
    
    private let disposeBag = DisposeBag()
    
    init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
        setupBindings()
    }
    
    private func setupBindings() {
        Observable
            .combineLatest(username, password, confirmPassword)
            .map { username, password, confirmPassword in
                return !username.isEmpty && password.count >= 4 && password == confirmPassword
            }
            .distinctUntilChanged()
            .bind(to: isRegisterEnabled)
            .disposed(by: disposeBag)
        
        registerTap
            .withLatestFrom(Observable.combineLatest(username, password, confirmPassword))
            .map { [weak self] username, password, confirmPassword in
                guard let self = self, password == confirmPassword else { return false }
                return self.authRepository.register(username: username.lowercased(), password: password)
            }
            .bind(to: registerResult)
            .disposed(by: disposeBag)
    }
}
