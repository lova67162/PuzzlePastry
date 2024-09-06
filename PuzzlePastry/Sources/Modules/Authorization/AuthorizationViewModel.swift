//
//  AuthorizationViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class AuthorizationViewModel: ObservableObject {
    @Published var email: String
    @Published var password: String
    
    @Published var showingAlert = false
    
    private var authService: AuthService = .init()
    @StateObject var sessionManager: SessionManager = .shared
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
    
    public static func == (lhs: AuthorizationViewModel, rhs: AuthorizationViewModel) -> Bool {
        return lhs.email == rhs.email &&
            lhs.password == rhs.password
    }
}

extension AuthorizationViewModel {
    func signInButtonClicked() {
        Task {
            let isSuccess = try await authService.login(email: email, password: password)
            
            if isSuccess && isFormValid {
                let fetchedUser = await authService.fetchUser()
                await MainActor.run {
                    sessionManager.userSession = Auth.auth().currentUser
                    sessionManager.currentUser = fetchedUser
                }
            } else {
                await MainActor.run {
                    showingAlert = true
                }
                print("Invalid log or password")
            }
        }
    }
    
    func clearState() {
        email = ""
        password = ""
    }

    func anonymousLogin() {
        SessionManager.shared.isAnonymous = true
    }
}

extension AuthorizationViewModel: AuthViewModelProtocol {
    var isFormValid: Bool {
        return email.isNotEmpty
        && email.contains("@")
        && password.isNotEmpty
        && password.count > 5
    }
}
