//
//  GameDomainModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 04.09.2024.
//

import Foundation
import RealmSwift
import UIKit

struct GameDomainModel {
    var id: UUID
    var image: String
    var cellsCount: Int
    var isResolved: Bool
        
    init(id: UUID = .init(),
         image: String = "",
         cellsCount: Int = 2,
         isResolved: Bool = false
    ) {
        self.id = id
        self.image = image
        self.cellsCount = cellsCount
        self.isResolved = isResolved
    }
}
