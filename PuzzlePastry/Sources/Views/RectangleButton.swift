//
//  RectangleButton.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 28.08.2024.
//

import SwiftUI

struct RectangleButton: View {
    private let text: String
    private let fullWidth: Bool
    private let fontPalette: FontPalette
    private let layout: MainButtonLayout
    private let style: RectangleButtonStyle
    private let action: () -> Void
    
    init(
        text: String,
        fullWidth: Bool = false,
        fontPalette: FontPalette,
        layout: MainButtonLayout,
        style: RectangleButtonStyle,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.fullWidth = fullWidth
        self.fontPalette = fontPalette
        self.layout = layout
        self.style = style
        self.action = action
    }
        
    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Text(text)
                    .lineLimit(2)
                    .font(fontPalette.font)
                    .glowBorder(color: style.textBorderColor.color, lineWidth: 6)
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(.white)
                    .if(fullWidth) {
                        $0.frame(maxWidth: .infinity)
                    }
            }
        )
        .padding(.horizontal, layout.contentHorizontalPadding)
        .padding(.vertical, layout.contentVerticalPadding)
        .background(
            RoundedRectangle(cornerRadius: 52)
                .foregroundStyle(style.backgroundColor.color)
                .shadow(color: style.shadowColor.color, radius: 10, x: 0, y: 0)
        )
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RectangleButton(text: "SIGN IN", fontPalette: .sign, layout: .regular, style: .dark, action: {})
//        .padding(.horizontal, 20)
}
