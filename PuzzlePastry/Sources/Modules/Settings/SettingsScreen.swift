//
//  SettingsScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import SwiftUI
import WebKit

struct SettingsScreen: View {
    // MARK: - Setup
    @ObservedObject private var viewModel: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isPresentWebView = false
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        contentView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(
                Image("signBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
    }
    
    var contentView: some View {
        VStack(spacing: 24) {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image("backButton")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60, alignment: .topLeading)
                        .padding(.top, 52)
//                        .padding(.horizontal, 24)
                })
                Spacer() // Добавляем Spacer для выравнивания кнопки влево
            }
            Spacer()
            VStack(alignment: .center, spacing: 24) {
                MainView(text: viewModel.name, style: .dark, layout: .main)
                MainView(text: viewModel.email, style: .light, layout: .main)
            }
            Spacer()
            HStack(spacing: 12) {
                RectangleButton(text: "LOG OUT", fontPalette: .delete, layout: .settingsLogOut, style: .light) {
                     viewModel.logOutButtonClicked()
                }
                RectangleButton(text: "DELETE \nACCOUNT", fontPalette: .delete, layout: .circle, style: .dark) {
                     viewModel.deleteAccoountButtonClicked()
                }
            }
            .padding(.vertical, 88)
            Button("PRIVACY POLICY") {
                isPresentWebView = true
            }
            .foregroundColor(.black)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .foregroundStyle(.white)
                    .shadow(color: ColorPalette.privacyPolicyShadow.color, radius: 10, x: 0, y: 0)
            )
            .padding(.bottom, 60)
            .sheet(isPresented: $isPresentWebView) {
                NavigationStack {
                    WebView(url: URL(string: "https://doc-hosting.flycricket.io/puzzlepastry-privacy-policy/8e709285-0af1-464c-926b-300671d55911/privacy")!)
                        .ignoresSafeArea()
                        .navigationTitle("Privacy Policy")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
        .padding(.horizontal, 32)
        .onAppear {
            viewModel.reloadDataSource()
        }
    }

}
    

#Preview {
    SettingsScreen(viewModel: .init(id: "1", name: "Kukulaku", email: "xz@gmail.com"))
}

struct WebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
