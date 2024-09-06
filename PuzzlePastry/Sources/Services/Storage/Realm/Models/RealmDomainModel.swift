//
//  RealmDomainModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation
import RealmSwift

final class RealmDomainModel: Object {
    @Persisted(primaryKey: true)  var id: UUID = .init()
    @Persisted var image: String = ""
    @Persisted var cellsCount: Int = 0
    @Persisted var isResolved: Bool = false
        
    convenience init(
        id: UUID = .init(),
        image: String,
        cellsCount: Int,
        isResolved: Bool
    ) {
        self.init()
        self.id = id
        self.image = image
        self.cellsCount = cellsCount
        self.isResolved = isResolved
    }
}
