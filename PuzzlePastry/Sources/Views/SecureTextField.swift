//
//  SecureTextField.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

struct SecureTextField: View {
    private var text: Binding<String>
    private let placeholder: String
    private let style: MainTextFieldStyle
    
    init(text: Binding<String>, placeholder: String, style: MainTextFieldStyle) {
        self.text = text
        self.placeholder = placeholder
        self.style = style
    }
        
    var body: some View {
        SecureField("",
                  text: text,
                  prompt: Text(placeholder)
                            .font(FontPalette.search.font)
                            .foregroundColor(style.textColor.color)
        )
        .textCase(.uppercase)
        .multilineTextAlignment(.center)
        .font(FontPalette.search.font)
        .foregroundStyle(style.textColor.color)
        .minimumScaleFactor(0.5)
        .glowBorder(color: style.textBorderColor.color, lineWidth: 4)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 48)
            .foregroundStyle(Color.white)
            .shadow(color: ColorPalette.shadowColor.color, radius: 4, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 48)
            .stroke(style: .init(lineWidth: 3, lineCap: .round, dash: [8]))
            .fill(style.borderColor.color)
        )
        
//        SecureField("",
//                  text: text,
//                  prompt: Text(placeholder)
//                            .font(FontPalette.search.font)
//                            .foregroundColor(ColorPalette.buttonText.color)
//        )
//        .textCase(.uppercase)
//        .font(FontPalette.search.font)
//        .foregroundStyle(ColorPalette.buttonText.color)
//        .padding(24)
//        .background(
//            RoundedRectangle(
//                cornerSize: .init(width: 20, height: 20)
//            )
//            .foregroundStyle(Color.white)
//            .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
//        )
//        .overlay(
//            RoundedRectangle(
//                cornerSize: .init(width: 20, height: 20)
//            )
//            .stroke(ColorPalette.buttonBackground.color, lineWidth: 1)
//        )
    }
}
