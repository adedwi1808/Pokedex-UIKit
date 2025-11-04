//
//  PokemonGridCell.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PokemonGridCell: UICollectionViewCell {
    
    static let identifier = "PokemonGridCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let pokemonImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(pokemonImageView)
        containerView.addSubview(nameLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pokemonImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(pokemonImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(pokemonImageView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonImageView.image = nil
        nameLabel.text = nil
        containerView.backgroundColor = .systemGray5
        pokemonImageView.kf.cancelDownloadTask()
    }
    
    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        
        guard let id = pokemon.url.split(separator: "/").last.map(String.init) else {
            return
        }
        
        let imageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        guard let url = URL(string: imageUrlString) else { return }
        
        pokemonImageView.kf.indicatorType = .activity
        
        pokemonImageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(0.2)),
                .processor(DownsamplingImageProcessor(size: CGSize(width: 150, height: 150))),
                .scaleFactor(UIScreen.main.scale)
            ]) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let imageResult):
                    let image = imageResult.image
                    
                    image.getAverageColor { averageColor in
                        DispatchQueue.main.async {
                            self.containerView.backgroundColor = averageColor ?? .systemGray5
                        }
                    }
                    
                case .failure:
                    self.containerView.backgroundColor = .systemGray5
                }
            }
    }
}
