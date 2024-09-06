//
//  MainTextField.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

struct MainTextField: View {
    private var text: Binding<String>
    private let placeholder: String
    private var style: MainTextFieldStyle
    
    init(text: Binding<String>, placeholder: String, style: MainTextFieldStyle) {
        self.text = text
        self.placeholder = placeholder
        self.style = style
    }
        
    var body: some View {
        TextField("",
                  text: text,
                  prompt: Text(placeholder)
                            .font(FontPalette.search.font)
                            .foregroundColor(style.textColor.color)
        )
        .textCase(.uppercase)
        .multilineTextAlignment(.center)
        .font(FontPalette.search.font)
        .foregroundStyle(style.textColor.color)
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
    }
}

#Preview {
    MainTextField(
        text: .constant("EMAIL... "),
        placeholder: "Search...", style: .light
    )
    .padding(20)
}

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}
