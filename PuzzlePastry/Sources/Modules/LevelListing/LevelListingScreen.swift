//
//  LevelListingScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

struct LevelListingScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: LevelListingViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: LevelListingViewModel, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        GeometryReader { geometry in
            let itemWidth = (geometry.size.width - 100) / 3
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("backButton")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60, alignment: .topLeading)
                            .padding(.top, 8)
                            .padding(.horizontal, 26)
                    })
                    Spacer() // Добавляем Spacer для выравнивания кнопки влево
                }
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("LEVEL \nSELECTION")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .glowBorder(color: ColorPalette.borderPink.color, lineWidth: 8)
                        .multilineTextAlignment(.center)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Array(repeating: GridItem(.fixed(itemWidth)), count: 3), spacing: 26) {
                            ForEach(viewModel.items, id: \.self) { item in
                                LevelItemView(viewModel: item, onTap: { _ in 
                                    path.append(MainRouting.game(item))
                                })
                                .frame(width: itemWidth, height: itemWidth)
                            }
                            
                        }
                        .padding(26)
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 48)
            .background(
                Image("mainBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
            .onAppear {
                viewModel.reloadData()
            }
        }
    }
}

#Preview {
    LevelListingScreen(viewModel: .init(items: [
//        .init(id: "1", image: "1"),
//        .init(id: "12115", image: "1"),
//        .init(id: "1632", image: "1"),
//        .init(id: "154", image: "1"),
//        .init(id: "1231", image: "1"),
//        .init(id: "132", image: "1"),
//        .init(id: "133", image: "1"),
//        .init(id: "121", image: "1"),
//        .init(id: "122", image: "1"),
//        .init(id: "111", image: "1"),
//        .init(id: "19", image: "1"),
//        .init(id: "18", image: "1"),
//        .init(id: "17", image: "1"),
        .init(id: "16", image: "1", cellsCount: 3, isResolved: false),
        .init(id: "15", image: "1", cellsCount: 3, isResolved: true),
        .init(id: "14", image: "1", cellsCount: 3, isResolved: true),
        .init(id: "13", image: "1", cellsCount: 3, isResolved: true),
        .init(id: "12", image: "1", cellsCount: 3, isResolved: true),
        .init(id: "11", image: "1", cellsCount: 3, isResolved: true)
    ]), path: .constant(.init()))
}
