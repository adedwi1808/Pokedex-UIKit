//
//  UINavigationController+XLPagerTabStrip.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 04/11/25.
//

import UIKit
import XLPagerTabStrip

extension UINavigationController: IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if let topVC = viewControllers.first as? IndicatorInfoProvider {
            return topVC.indicatorInfo(for: pagerTabStripController)
        }
        return IndicatorInfo(title: "Tab")
    }
}
