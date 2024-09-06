//
//  RegistrationViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation
import FirebaseAuth

final class RegistrationViewModel: ObservableObject {
    @Published var name: String
    @Published var email: String
    @Published var password: String
    @Published var confirmPassword: String = ""
    
    @Published var showingAlert = false
    
    private var authService: AuthService = .init()

    init(name: String = "", email: String = "", password: String = "", confirmPassword: String = "") {
        self.name = name
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}

extension RegistrationViewModel {
    func signUpButtonClicked() {
        Task {
            let isSuccess = try await authService.register(email: email, password: password, name: name)
            
            if isSuccess && isFormValid {
                let currentUser = await authService.fetchUser()
                
                await MainActor.run {
                    SessionManager.shared.userSession = Auth.auth().currentUser
                    SessionManager.shared.currentUser = currentUser
                }
            } else {
                await MainActor.run {
                    showingAlert = true
                }
                print("isSuccess \(isSuccess)")
            }
        }
    }

    func clearState() {
        name = ""
        email = ""
        password = ""
        confirmPassword = ""
    }
}

extension RegistrationViewModel: AuthViewModelProtocol {
    var isFormValid: Bool {
        return email.isNotEmpty
        && email.contains("@")
        && password.isNotEmpty
        && password.count > 5
        && confirmPassword == password
        && name.isNotEmpty
    }
}
