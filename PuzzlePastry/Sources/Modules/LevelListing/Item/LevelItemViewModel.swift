//
//  LevelItemViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 29.08.2024.
//

import Foundation

final class LevelItemViewModel: ObservableObject, Hashable {
    @Published var id: String
    @Published var image: String
    @Published var cellsCount: Int
    @Published var isResolved: Bool
    
    init(id: String, image: String, cellsCount: Int, isResolved: Bool) {
        self.id = id
        self.image = image
        self.cellsCount = cellsCount
        self.isResolved = isResolved
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LevelItemViewModel, rhs: LevelItemViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.cellsCount == rhs.cellsCount &&
            lhs.isResolved == rhs.isResolved
    }
}
