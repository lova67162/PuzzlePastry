//
//  AuthorizationScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI

enum AuthorizationRouting: Hashable {
    case registation
}

struct AuthorizationScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: AuthorizationViewModel
    @State private var path: NavigationPath = .init()
    @State private var showingAlert = false
    
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 24) {
                Spacer()
                VStack(alignment: .center, spacing: 24) {
                    MainTextField(text: $viewModel.email, placeholder: "EMAIL", style: .dark)
                        .keyboardType(.emailAddress)
                    SecureTextField(text: $viewModel.password, placeholder: "PASSWORD", style: .light)
                }
                
                Button(action: {
                    viewModel.anonymousLogin()
                }, label: {
                    Text("ANONYMOUS LOG IN")
                        .foregroundColor(.white)
                        .bold()
                        .glowBorder(color: ColorPalette.borderPink.color, lineWidth: 6)
                        .padding(.vertical, 12)
                })
                
                RectangleButton(text: "SIGN IN", fontPalette: .sign, layout: .regular, style: .dark) {
                    viewModel.signInButtonClicked()
                }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("SOMETHING WENT WRONG."), message: Text("AUTHENTICATION ERROR. PLEASE CHECK YOUR CREDENTIALS AND TRY AGAIN."), dismissButton: .default(Text("OK")))
                }
                
                Button(action: {
                    path.append(AuthorizationRouting.registation)
                }, label: {
                    Text("YOU DON'T HAVE AN ACCOUNT YET? \n SIGN UP NOW?")
                        .foregroundColor(.black)
                        .padding(.top, 50)
                        .padding(.bottom, 60)
                        .padding(.horizontal, 12)
                        .frame(maxWidth: .infinity, alignment: .center)
                })
            }
            .navigationDestination(for: AuthorizationRouting.self) { router in
                switch router {
                case .registation:
                    RegistrationScreen(viewModel: .init())
                        .navigationBarBackButtonHidden(true)
                }
            }
            .padding(.horizontal, 32)
            .ignoresSafeArea(.keyboard, edges: .all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
}
//}

#Preview {
    AuthorizationScreen(viewModel: .init(email: "email", password: ""))
}
