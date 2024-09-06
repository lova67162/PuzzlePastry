//
//  LevelItemView.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 29.08.2024.
//

import SwiftUI

struct LevelItemView: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: LevelItemViewModel
    var onTap: ((LevelItemViewModel) -> Void)?
    
    init(viewModel: LevelItemViewModel, onTap: ((LevelItemViewModel) -> Void)? = nil) {
        self.viewModel = viewModel
        self.onTap = onTap
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            if viewModel.isResolved {
                Image(viewModel.image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: width, height: width)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .clipped()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: .init(lineWidth: 3, lineCap: .round, dash: [8]))
                            .fill(ColorPalette.borderPink.color)
                    )
                    .onTapGesture {
                        onTap?(viewModel)
                    }
            } else {
                ZStack {
                    Image(viewModel.image)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: width, height: width)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                        .clipped()
                    Image("lock")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: width, height: width)
                        .opacity(0.8)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(style: .init(lineWidth: 3, lineCap: .round, dash: [8]))
                                .fill(ColorPalette.borderPink.color)
                        )
                }
            }
        }
    }

}

#Preview {
    LevelItemView(viewModel: .init(id: "1", image: "test", cellsCount: 2, isResolved: true), onTap: {_ in })
}
