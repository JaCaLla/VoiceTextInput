//
//  DetailViewModel.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import SwiftUI

protocol DetailViewModelProtocol {
    
}

final class DetailViewModel: ObservableObject {
    
   @Published var character: Character
    
    init(character: Character) {
        self.character = character
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    
}
