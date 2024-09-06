//
//  GameViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 29.08.2024.
//

import Foundation

final class GameViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var image: String
    @Published var gridCount: Int
    @Published var isResolved: Bool
    
    let gameStorage: GameDomainModelStorage = .init()
    
    init(id: String, image: String, gridCount: Int, isResolved: Bool) {
        self.id = id
        self.image = image
        self.gridCount = gridCount
        self.isResolved = isResolved
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: GameViewModel, rhs: GameViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.gridCount == rhs.gridCount &&
            lhs.isResolved == rhs.isResolved
    }
}

extension GameViewModel {
    func levelPassed() {
        let levels = gameStorage.read()
        guard let currentIndex = levels.firstIndex(where: { $0.id.uuidString == id }) else {
            return
        }
        
        let nextIndex = levels.index(after: currentIndex)
        guard nextIndex < levels.count else {
            return
        }
        
        var nextItem = levels[nextIndex]
        nextItem.isResolved = true
        
        gameStorage.store(item: nextItem)
    }
    
    func getLevel() -> Int {
        let levels = gameStorage.read()
        guard let currentIndex = levels.firstIndex(where: { $0.id.uuidString == id }) else {
            return 1
        }
        var result = currentIndex
        result += 1
        
        return result
    }
}
