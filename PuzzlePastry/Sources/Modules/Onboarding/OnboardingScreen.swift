//
//  OnboardingScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

struct OnboardingScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: OnboardingViewModel
    @State private var isActive: Bool = false

    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        currentView
            .edgesIgnoringSafeArea(.all)
            .background(
                Image("loaderBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
    }
    
    @ViewBuilder var currentView: some View {
        if isActive {
            authorisationView
        } else {
            loaderView
        }
    }
    
    var authorisationView: some View {
        RootScreen()
    }
    
    var loaderView: some View {
        VStack {
            Spacer()
            CustomLoader()
                .frame(height: 80)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            viewModel.loadData()
                            isActive = true
                        }
                    }
                }
            Text("LOADING...")
                .font(.custom("Arial", size: 24))
                .foregroundColor(.white)
                .glowBorder(color: ColorPalette.borderPink.color, lineWidth: 4)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 180)
        .padding(.horizontal, 32)
    }
}

#Preview {
    OnboardingScreen(viewModel: .init(isShowing: true))
}

struct CustomLoader: View {
    @State private var progress: CGFloat = 0.0
    let image = UIImage(named: "loader")!
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width * progress, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .onAppear {
                        withAnimation(.linear(duration: 3)) {
                            progress = 1.0
                        }
                    }
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 50)
                .foregroundColor(.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 48)
            .stroke(style: .init(lineWidth: 3, lineCap: .round, dash: [8]))
            .fill(ColorPalette.borderPink.color)
        )
    }
}
