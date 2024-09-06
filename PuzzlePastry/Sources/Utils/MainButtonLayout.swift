//
//  MainButtonLayout.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation
import SwiftUI

public struct MainButtonLayout {
    // MARK: - Properties
    let contentVerticalPadding: CGFloat
    let contentHorizontalPadding: CGFloat
    
    let maxHeight: CGFloat?
    let maxWidth: CGFloat
    
    init(
        contentVerticalPadding: CGFloat,
         contentHorizontalPadding: CGFloat,
         maxHeight: CGFloat? = nil,
         maxWidth: CGFloat
    ) {
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
    }
}

// MARK: - Catalog values
public extension MainButtonLayout {
    static let regular: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 32,
        contentHorizontalPadding: 24,
        maxWidth: .infinity
    )
    
    static let sign: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 16,
        contentHorizontalPadding: 48,
        maxWidth: .infinity
    )
    
    static let logOut: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 12,
        contentHorizontalPadding: 12,
        maxWidth: .infinity
    )
    
    static let circle: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 16,
        contentHorizontalPadding: 16,
        maxHeight: .infinity,
        maxWidth: .infinity
    )
    
    static let settingsLogOut: MainButtonLayout = MainButtonLayout(
        contentVerticalPadding: 24,
        contentHorizontalPadding: 24,
        maxWidth: .infinity
    )
    
//    static let settingsDelete: MainButtonLayout = MainButtonLayout(
//        contentVerticalPadding: 12,
//        contentHorizontalPadding: 24,
//        maxWidth: .infinity
//    )
}
