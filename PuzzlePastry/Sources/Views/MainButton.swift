//
//  MainButton.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

struct MainButton: View {
    private let text: String
    private let fontPalette: FontPalette
    private let layout: MainButtonLayout
    private let action: () -> Void
    
    init(
        text: String,
        fontPalette: FontPalette,
        layout: MainButtonLayout,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.fontPalette = fontPalette
        self.layout = layout
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
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(ColorPalette.borderPink.color)
                    .glowBorder(color: ColorPalette.textBorderBurgundy.color, lineWidth: 5)
                    .frame(maxWidth: layout.maxWidth, maxHeight: layout.maxHeight)
                    .background(
                        Circle()
                            .foregroundStyle(.white)
                            .shadow(color: ColorPalette.startButtonShadow.color, radius: 8, x: 0, y: 0)
                    )
                    .overlay(
                        Circle()
                        .stroke(style: .init(lineWidth: 8, lineCap: .round, dash: [20]))
                        .fill(ColorPalette.borderPink.color)
                    )
            }
        )
        .padding(.horizontal, layout.contentHorizontalPadding)
        .padding(.vertical, layout.contentVerticalPadding)
    }
}

#Preview {
    MainButton(text: "test test", fontPalette: .hTwo, layout: .circle, action: {})
}
