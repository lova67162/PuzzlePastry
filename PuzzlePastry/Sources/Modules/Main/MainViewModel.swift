//
//  MainViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var showingAlert = false
    let gameStorage: GameDomainModelStorage = .init()
}

extension MainViewModel {
    func startButtonClicked() {
        
    }
    
    func settingsButtonClicked() {
        
    }
    
    func reloadData() -> [LevelItemViewModel] {
        gameStorage.read().compactMap({ makeCellViewModel(for: $0) })
    }
    
    func makeCellViewModel(
        for model: GameDomainModel
    ) -> LevelItemViewModel? {
        return .init(
            id: model.id.uuidString,
            image: model.image,
            cellsCount: model.cellsCount,
            isResolved: model.isResolved
        )
    }
}
