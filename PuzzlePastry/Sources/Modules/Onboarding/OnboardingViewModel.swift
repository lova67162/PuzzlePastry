//
//  OnboardingViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var isShowing: Bool = false
    
    init(isShowing: Bool = false) {
        self.isShowing = isShowing
    }
}

extension OnboardingViewModel {
    func loadData() {
        let gameStorage: GameDomainModelStorage = .init()
        
        guard gameStorage.read().isEmpty else { return }
        
        gameStorage.store(item: .init(image: "1", cellsCount: 2, isResolved: true))
        gameStorage.store(item: .init(image: "2", cellsCount: 2, isResolved: false))
        gameStorage.store(item: .init(image: "3", cellsCount: 2, isResolved: false))
        gameStorage.store(item: .init(image: "4", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "5", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "6", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "7", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "8", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "9", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "10", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "11", cellsCount: 3, isResolved: false))
        gameStorage.store(item: .init(image: "12", cellsCount: 4, isResolved: false))
        gameStorage.store(item: .init(image: "13", cellsCount: 4, isResolved: false))
        gameStorage.store(item: .init(image: "14", cellsCount: 4, isResolved: false))
        gameStorage.store(item: .init(image: "15", cellsCount: 4, isResolved: false))
        gameStorage.store(item: .init(image: "16", cellsCount: 4, isResolved: false))
        gameStorage.store(item: .init(image: "17", cellsCount: 4, isResolved: false))
    }
}
