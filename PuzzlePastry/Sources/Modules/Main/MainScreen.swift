//
//  MainScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

enum MainRouting: Hashable {
    case levelListing
    case game(LevelItemViewModel)
    case settings
}

struct MainScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: MainViewModel
    @State private var path: NavigationPath = .init()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                MainButton(text: "START \nGAME", fontPalette: .hTwo, layout: .circle) {
                    path.append(MainRouting.levelListing)
                }
                .padding(36)
                Button(action: {
                    path.append(MainRouting.settings)
                }, label: {
                    Text("SETTINGS")
                        .foregroundColor(ColorPalette.settingsTextColor.color)
                        .glowBorder(color: ColorPalette.textBorderDarkBlue.color, lineWidth: 6)
                        .font(FontPalette.sign.font)
                        .padding(.horizontal, 48)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 48)
                                .foregroundStyle(.white)
                                .shadow(color: ColorPalette.privacyPolicyShadow.color, radius: 10, x: 0, y: 0)
                        )
                        .padding(.bottom, 60)
                })
            }
            .navigationDestination(for: MainRouting.self) { router in
                switch router {
                case .levelListing:
                    LevelListingScreen(viewModel: .init(items: viewModel.reloadData()), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .game(let item):
                    GameScreen(viewModel: .init(id: item.id, image: item.image, gridCount: item.cellsCount, isResolved: item.isResolved), path: $path)
                        .navigationBarBackButtonHidden(true)
                case .settings:
                    SettingsScreen(viewModel: .init())
                        .navigationBarBackButtonHidden(true)
                }
            }
            .ignoresSafeArea(edges: .all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(
                Image("mainBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
        }
    }
}

#Preview {
    MainScreen(viewModel: .init())
}
