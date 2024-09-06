//
//  MainViewLayout.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation

public struct MainViewLayout {
    // MARK: - Properties
    let contentVerticalPadding: CGFloat
    let contentHorizontalPadding: CGFloat
    
    init(
        contentVerticalPadding: CGFloat,
        contentHorizontalPadding: CGFloat
    ) {
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
    }
}

// MARK: - Catalog values
public extension MainViewLayout {
    static let main: MainViewLayout = MainViewLayout(
        contentVerticalPadding: 42,
        contentHorizontalPadding: 42
    )
}
