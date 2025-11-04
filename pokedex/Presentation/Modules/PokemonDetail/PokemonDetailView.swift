//
//  PokemonDetail.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import SnapKit

final class PokemonDetailView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let pokemonImageView = UIImageView()
    let nameLabel = UILabel()
    let abilitiesLabel = UILabel()
    let abilitiesValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { $0.edges.equalTo(safeAreaLayoutGuide) }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.backgroundColor = .secondarySystemBackground
        pokemonImageView.layer.cornerRadius = 8
        
        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        nameLabel.textAlignment = .center
        
        abilitiesLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        abilitiesLabel.text = "Abilities:"
        
        abilitiesValueLabel.font = .systemFont(ofSize: 17)
        abilitiesValueLabel.numberOfLines = 0
        
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(abilitiesLabel)
        contentView.addSubview(abilitiesValueLabel)
        
        pokemonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(pokemonImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        abilitiesLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(24)
            $0.leading.equalTo(nameLabel)
        }
        
        abilitiesValueLabel.snp.makeConstraints {
            $0.top.equalTo(abilitiesLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(nameLabel)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
