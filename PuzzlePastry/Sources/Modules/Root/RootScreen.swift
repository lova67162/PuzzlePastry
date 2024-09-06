//
//  RootScreen.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 03.09.2024.
//

import SwiftUI

enum RootRouting: Hashable {
    case authorization
    case main
}

struct RootScreen: View {
    @StateObject var sessionManager: SessionManager = .shared
    
    var body: some View {
        if sessionManager.isLoggedIn {
            MainScreen(viewModel: .init())
        } else {
            AuthorizationScreen(viewModel: .init())
        }
    }
}

#Preview {
    RootScreen()
}
