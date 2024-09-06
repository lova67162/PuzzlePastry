//
//  MainTextFieldStyle.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 30.08.2024.
//

import Foundation
import UIKit

public struct MainTextFieldStyle {
    // MARK: - Properties
    let textColor: ColorPalette
    let textBorderColor: ColorPalette
    let borderColor: ColorPalette

    init(textColor: ColorPalette, textBorderColor: ColorPalette, borderColor: ColorPalette) {
        self.textColor = textColor
        self.textBorderColor = textBorderColor
        self.borderColor = borderColor
    }
}

// MARK: - Catalog values
public extension MainTextFieldStyle {
    static let light: MainTextFieldStyle = MainTextFieldStyle(
        textColor: .textTurquoise,
        textBorderColor: .textBorderDarkBlue,
        borderColor: .borderTurquoiseBlue
    )
    
    static let dark: MainTextFieldStyle = MainTextFieldStyle(
        textColor: .textCoral,
        textBorderColor: .textBorderBurgundy,
        borderColor: .borderPink
    )
}
