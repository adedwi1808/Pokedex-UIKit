//
//  HomeView.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import SnapKit

final class HomeView: UIView {

    let collectionView: UICollectionView
    let searchController = UISearchController(searchResultsController: nil)
    
    private static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let padding: CGFloat = 16
        let totalHorizontalPadding = padding * 6
        let itemWidth = (UIScreen.main.bounds.width - totalHorizontalPadding) / 3
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 30)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return layout
    }

    override init(frame: CGRect) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeView.createLayout())
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        backgroundColor = .systemBackground

        searchController.searchBar.placeholder = "Cari Nama Pokemon"
        searchController.obscuresBackgroundDuringPresentation = false

        collectionView.register(PokemonGridCell.self, forCellWithReuseIdentifier: PokemonGridCell.identifier)
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
