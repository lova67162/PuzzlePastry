//
//  ColorPalette.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import UIKit
import SwiftUI

enum ColorPalette {
    case darkButtonBackground
    case darkButtonShadow
    
    case lightButtonBackground
    case lightButtonShadow
    
    case borderPink
    case textTurquoise
    case textBorderDarkBlue
    case borderTurquoiseBlue
    case textCoral
    case textBorderBurgundy
    case privacyPolicyShadow
    case settingsTextColor
    case startButtonShadow
    
    case shadowColor
    
    var uiColor: UIColor {
        switch self {
        case .darkButtonBackground:
            return .init(red: 255, green: 42, blue: 122, alpha: 1) //#FF2A7A
        case .darkButtonShadow:
            return .init(red: 181, green: 28, blue: 87, alpha: 1) //#B51C57
        case .lightButtonBackground:
            return .init(red: 40, green: 190, blue: 255, alpha: 1) //#28BEFF
        case .lightButtonShadow:
            return .init(red: 14, green: 87, blue: 119, alpha: 1) //#0E5777
        case .shadowColor:
            return .init(white: 0, alpha: 0.25)
        case .borderPink:
            return .init(red: 228, green: 45, blue: 114, alpha: 1) //#E42D72
        case .textTurquoise:
            return .init(red: 64, green: 152, blue: 180, alpha: 1) // #4098B4
        case .textBorderDarkBlue:
            return .init(red: 0, green: 35, blue: 125, alpha: 1) //#00237D
        case .borderTurquoiseBlue:
            return .init(red: 0, green: 134, blue: 176, alpha: 1) //#0086B0
        case .textCoral:
            return .init(red: 255, green: 126, blue: 175, alpha: 1) //#FF7EAF
        case .textBorderBurgundy:
            return .init(red: 112, green: 0, blue: 47, alpha: 1) //#70002F
        case .privacyPolicyShadow:
            return .init(red: 9, green: 162, blue: 200, alpha: 1) //#09A2C8
        case .settingsTextColor:
            return .init(red: 0, green: 157, blue: 207, alpha: 1) //#009DCF
        case .startButtonShadow:
             return .init(red: 255, green: 107, blue: 186, alpha: 1) //#FF6BBA
        }
    }
    
    var color: Color {
        return .init(uiColor: uiColor)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
}
