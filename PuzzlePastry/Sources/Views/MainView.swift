//
//  MainView.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

struct MainView: View {
    private var text: String
    private let style: MainTextFieldStyle
    private let layout: MainViewLayout
    
    init(text: String, style: MainTextFieldStyle, layout: MainViewLayout) {
        self.text = text
        self.style = style
        self.layout = layout
    }
    
    var body: some View {
        HStack {
            Text(text)
            .textCase(.uppercase)
            .multilineTextAlignment(.center)
            .font(FontPalette.search.font)
            .foregroundStyle(style.textColor.color)
            .glowBorder(color: style.textBorderColor.color, lineWidth: 4)
            .padding(24)
            .frame(maxWidth: .infinity)
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
//            Text(text)
//                .bold()
//                .foregroundStyle(.white)
//                .font(.title)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, layout.contentHorizontalPadding)
//                .padding(.vertical, layout.contentVerticalPadding)
//                .background(
//                    RoundedRectangle(
//                        cornerSize: .init(width: 24, height: 24)
//                    )
//                    .foregroundStyle(Color.white)
//                    .shadow(color: ColorPalette.shadowColor.color, radius: 3, x: 2, y: 4)
//                )
//                .overlay(
//                    RoundedRectangle(
//                        cornerSize: .init(width: 24, height: 24)
//                    )
//                    .stroke(.clear, lineWidth: 1)
//                )
        }
    }
}

#Preview {
    MainView(text: "123", style: .dark, layout: .main)
}
