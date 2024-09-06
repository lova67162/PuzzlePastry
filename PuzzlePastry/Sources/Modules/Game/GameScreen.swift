//
//  GameScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 29.08.2024.
//

import SwiftUI

struct GameScreen: View {
    @ObservedObject private var viewModel: GameViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: GameViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    @State private var imagePieces: [UIImage] = []
    @State private var originalImagePieces: [UIImage] = []
    @State private var selectedIndices: [Int] = []
    @State private var isGameWon = false

    var body: some View {
        currentView
            .ignoresSafeArea(.all)
            .background(
                Image("mainBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
    }
    
    @ViewBuilder var currentView: some View {
        if isGameWon {
            gameWonView
        } else {
            gameView
        }
    }
    
    var gameWonView: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let gridSize = min(screenWidth, screenHeight) * 0.85
            VStack(spacing: 24) {
                Image(viewModel.image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: gridSize, maxHeight: gridSize)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(
                        Color.white
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: .init(lineWidth: 3, lineCap: .round, dash: [8]))
                            .fill(ColorPalette.borderPink.color)
                    )
                RectangleButton(text: "OK", fontPalette: .sign, layout: .sign, style: .light) {
                    viewModel.levelPassed()
                    dismiss()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
    
    var gameView: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let gridSize = min(screenWidth, screenHeight) * 0.85 // Размер сетки - 85% от меньшего измерения экрана
            let pieceSize = gridSize / CGFloat(viewModel.gridCount) // Размер каждой части изображения
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image("backButton")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60, alignment: .topLeading)
                        .padding(.top, 52)
                        .padding(.horizontal, 26)
                })
                Spacer() // Добавляем Spacer для выравнивания кнопки влево
            }
            Spacer()
            Text("LEVEL \(viewModel.getLevel())")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .glowBorder(color: ColorPalette.borderPink.color, lineWidth: 8)
                .multilineTextAlignment(.center)
            Grid(gridCount: viewModel.gridCount, pieceSize: pieceSize) {
                ForEach(0 ..< viewModel.gridCount * viewModel.gridCount, id: \.self) { index in
                    if index < imagePieces.count {
                        Image(uiImage: imagePieces[index])
                            .resizable()
                            .frame(width: pieceSize, height: pieceSize)
                            .border(Color.black)
                            .onTapGesture {
                                handleTap(index: index)
                            }
                    }
                }
            }
            .padding(.vertical, 12)
            .background(
                Color.white
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: .init(lineWidth: 3, lineCap: .round, dash: [8]))
                    .fill(ColorPalette.borderPink.color)
            )
            .padding(.horizontal, 12)
            .padding(.bottom, 100)
            Spacer()
            .onAppear(perform: setupGame)
        }
    }
}
    
    
    private func handleTap(index: Int) {
        if selectedIndices.contains(index) {
            selectedIndices.removeAll(where: { $0 == index })
        } else {
            selectedIndices.append(index)
        }

        if selectedIndices.count == 2 {
            swapPieces()
        }
    }

    private func swapPieces() {
        let firstIndex = selectedIndices[0]
        let secondIndex = selectedIndices[1]
        
        imagePieces.swapAt(firstIndex, secondIndex)
        
        selectedIndices.removeAll()
        
        checkWinCondition()
    }

    private func checkWinCondition() {
        if imagePieces == originalImagePieces {
            isGameWon = true
        }
    }

    private func splitImage(image: UIImage) -> [UIImage] {
        let cgImage = image.cgImage!
        let width = CGFloat(cgImage.width) / CGFloat(viewModel.gridCount)
        let height = CGFloat(cgImage.height) / CGFloat(viewModel.gridCount)
        
        var pieces: [UIImage] = []
        
        for row in 0 ..< viewModel.gridCount {
            for col in 0 ..< viewModel.gridCount {
                let rect = CGRect(x: CGFloat(col) * width, y: CGFloat(row) * height, width: width, height: height)
                if let croppedCGImage = cgImage.cropping(to: rect) {
                    let piece = UIImage(cgImage: croppedCGImage)
                    pieces.append(piece)
                }
            }
        }
        
        return pieces
    }

    private func setupGame() {
        originalImagePieces = splitImage(image: .init(named: viewModel.image) ?? ._1)
        imagePieces = originalImagePieces
        imagePieces.shuffle()
    }
}

struct Grid<Content: View>: View {
    let gridCount: Int
    let pieceSize: CGFloat
    let content: () -> Content

    init(gridCount: Int, pieceSize: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.gridCount = gridCount
        self.pieceSize = pieceSize
        self.content = content
    }

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(pieceSize)), count: gridCount), content: content)
    }
}


#Preview {
    GameScreen(viewModel: .init(id: "1", image: "", gridCount: 2, isResolved: true), path: .constant(.init()))
}


