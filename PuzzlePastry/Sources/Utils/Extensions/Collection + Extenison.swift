//
//  Collection + Extenison.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation

extension Collection {
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func withoutNils<T>() -> [T] where Element == Optional<T> {
        return compactMap { $0 }
    }
}
