//
//  CharacterViewModel.swift
//  APIRestCombine
//
//  Created by Javier Calatrava on 16/12/24.
//

import SwiftUI
@preconcurrency import Combine

@MainActor
final class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    var cancellables = Set<AnyCancellable>()
        
    func fetch() async {
        characters = []
        let result = await currentApp.dataManager.fetchCharacters(CharacterService())
        switch result {
        case .success(let characters):
            self.characters = characters
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchComb() {
        let api = CharacterServiceComb()
        api.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetch successful")
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { characters in
                self.characters = characters.results.map { Character($0) }
            })
            .store(in: &cancellables)
    }
    
    func fetchFut() {
        let api = CharacterServiceComb()
    api.fetchFut()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetch successful")
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }, receiveValue: { characters in
                self.characters = characters.results.map { Character($0) }
            })
            .store(in: &cancellables)
    }
}

