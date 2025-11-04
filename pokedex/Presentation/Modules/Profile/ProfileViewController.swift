//
//  ProfileViewController.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import XLPagerTabStrip

final class ProfileViewController: UIViewController, IndicatorInfoProvider {
    
    private let viewModel: ProfileViewModel
    private let disposeBag = DisposeBag()
    
    private let usernameLabel = UILabel()
    private let logoutButton = UIButton(type: .system)
    var onLogout: (() -> Void)?
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        usernameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        usernameLabel.textAlignment = .center
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.tintColor = .white
        logoutButton.layer.cornerRadius = 8
        logoutButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        view.addSubview(usernameLabel)
        view.addSubview(logoutButton)
        
        usernameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        logoutButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(usernameLabel)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(30)
            $0.height.equalTo(48)
        }
        
    }
    
    private func bindViewModel() {
        viewModel.username
            .map { "Hello, \($0)" }
            .drive(usernameLabel.rx.text)
            .disposed(by: disposeBag)
        
        logoutButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onLogout?()
            })
            .disposed(by: disposeBag)
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Profile")
    }
}
