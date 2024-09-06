//
//  GameDomainModelStorage.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 04.09.2024.
//

import Foundation
import RealmSwift

final class GameDomainModelStorage {
    let storage: RealmStorage = .shared
    
    func store(item: GameDomainModel) {
        storage.create(object: transformToDBO(domainModel: item))
    }
    
//    func store(items: [GameDomainModel]) {
//        storage.create(objects: transformToDBO(domainModels: items))
//    }
    
    func read() -> [GameDomainModel] {
        guard let results = storage.read(type: RealmDomainModel.self) else {
            return []
        }
    
        return results
//            .sorted(by: \.creationDate, ascending: false)
            .compactMap(transformToDomainModel)
    }
        
    func delete(ids: [UUID]) {
        storage.delete(type: RealmDomainModel.self, where: { $0.id.in(ids) })
    }
}

private extension GameDomainModelStorage {
    func transformToDBO(domainModel model: GameDomainModel) -> RealmDomainModel {
        return .init(
            id: model.id,
            image: model.image,
            cellsCount: model.cellsCount,
            isResolved: model.isResolved
        )
    }
    
//    func transformToDBO(domainModels models: [GameDomainModel]) -> [RealmDomainModel] {
//        return models.map { model in
//                .init(
//                    id: model.id,
//                    image: model.image,
//                    title: model.title,
//                    price: model.price,
//                    isFavorite: model.isFavorite,
//                    descriptions: model.descriptions
//                )
//        }
//    }
    
    func transformToDomainModel(model: RealmDomainModel) -> GameDomainModel? {
        return .init(
            id: model.id,
            image: model.image,
            cellsCount: model.cellsCount,
            isResolved: model.isResolved
        )
    }
}
