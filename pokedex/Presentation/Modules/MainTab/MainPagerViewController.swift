//
//  MainPagerViewController.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import XLPagerTabStrip
import SnapKit

final class MainPagerViewController: ButtonBarPagerTabStripViewController {
    var tabViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonBar()
        layoutViews()
        reloadPagerTabStripView()
    }
    
    private func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .systemBackground
        settings.style.buttonBarItemBackgroundColor = .systemBackground
        settings.style.selectedBarBackgroundColor = .systemBlue
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 15)
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .label
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarHeight = 48
        
        buttonBarView.backgroundColor = .systemBackground
    }
    
    private func layoutViews() {
        buttonBarView.removeFromSuperview()
        containerView.removeFromSuperview()
        
        view.addSubview(buttonBarView)
        view.addSubview(containerView)
        
        buttonBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(buttonBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        tabViewControllers
    }
}


