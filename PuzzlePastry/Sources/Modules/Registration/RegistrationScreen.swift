//
//  RegistrationScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

struct RegistrationScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            VStack(alignment: .center, spacing: 24) {
                MainTextField(text: $viewModel.name, placeholder: "NAME", style: .dark)
                MainTextField(text: $viewModel.email, placeholder: "EMAIL", style: .light)
                    .keyboardType(.emailAddress)
                SecureTextField(text: $viewModel.password, placeholder: "PASSWORD", style: .dark)
                SecureTextField(text: $viewModel.confirmPassword, placeholder: "Confirm password", style: .light)
            }
                        
            RectangleButton(text: "SIGN UP", fontPalette: .sign, layout: .regular, style: .light) {
                    viewModel.signUpButtonClicked()
                
                }
            .padding(.top, 36)
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("SOMETHING WENT WRONG."), message: Text("AUTHENTICATION ERROR. PLEASE CHECK YOUR CREDENTIALS AND TRY AGAIN."), dismissButton: .default(Text("OK")))
                }

            Button("DO YOU ALREADY HAVE AN ACCOUNT? \nSIGN IN") {
                dismiss()
            }
            .foregroundColor(.black)
            .padding(.top, 50)
            .padding(.bottom, 60)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, 32)
        .ignoresSafeArea(.keyboard, edges: .all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(
            Image("signBackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
        .onDisappear {
            viewModel.clearState()
        }
    }
}

#Preview {
    RegistrationScreen(viewModel: .init(name: "", email: "", password: ""))
}
