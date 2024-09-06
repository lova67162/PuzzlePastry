//
//  LevelListingViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation

final class LevelListingViewModel: ObservableObject {
    @Published var items: [LevelItemViewModel]
    
    init(items: [LevelItemViewModel]) {
        self.items = items
    }
    
    func reloadData() {
        let gameStorage: GameDomainModelStorage = .init()
        let newItems = gameStorage.read().compactMap({ makeCellViewModel(for: $0) })
        items = newItems
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

