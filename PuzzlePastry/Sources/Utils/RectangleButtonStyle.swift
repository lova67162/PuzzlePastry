//
//  RectangleButtonStyle.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 30.08.2024.
//

import UIKit

public struct RectangleButtonStyle {
    // MARK: - Properties
    let backgroundColor: ColorPalette
    let textBorderColor: ColorPalette
    let shadowColor: ColorPalette

    init(backgroundColor: ColorPalette, textBorderColor: ColorPalette, shadowColor: ColorPalette) {
        self.backgroundColor = backgroundColor
        self.textBorderColor = textBorderColor
        self.shadowColor = shadowColor
    }
}

// MARK: - Catalog values
public extension RectangleButtonStyle {
    static let light: RectangleButtonStyle = RectangleButtonStyle(
        backgroundColor: .lightButtonBackground,
        textBorderColor: .textBorderDarkBlue,
        shadowColor: .lightButtonShadow
    )
    
    static let dark: RectangleButtonStyle = RectangleButtonStyle(
        backgroundColor: .darkButtonBackground,
        textBorderColor: .textBorderBurgundy,
        shadowColor: .darkButtonShadow
    )
}

