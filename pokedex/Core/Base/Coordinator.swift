//
//  Coordinator.swift
//  pokedex
//
//  Created by Ade Dwi Prayitno on 03/11/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
