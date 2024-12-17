//
//  DetailCoordinator.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import UIKit
@MainActor
final class DetailCoordinator {

    // MARK: - Private attributes
    private var navigationController = UINavigationController()
    private var character: Character?
    
    // MARK: - Public helpers
    func start(navigationController: UINavigationController, character: Character) {
        self.character = character
        self.navigationController = navigationController
        
        presentCharacterDetail()
    }
    
    // MARK: - Private methods
    private func presentCharacterDetail() {
        guard let character else { return }
        let viewModel = DetailViewModel(character: character)
       let viewController = DetailViewController(viewModel: viewModel)
       navigationController.pushViewController(viewController, animated: true)
    }
}
