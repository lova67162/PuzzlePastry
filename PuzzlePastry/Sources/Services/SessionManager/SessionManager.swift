//
//  SessionManager.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 22.08.2024.
//

import FirebaseAuth

final class SessionManager: ObservableObject {
    static var shared: SessionManager = .init()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    @Published var isAnonymous: Bool = false
    
    var isLoggedIn: Bool {
        return currentUser != nil || isAnonymous
    }
    
    var subscritpions: [any NSObjectProtocol] = []
    
    // MARK: Services
    private let authService: AuthService = .init()
    
    private init() {
        subscritpions.append(
            Auth.auth().addStateDidChangeListener { [weak self] auth, user in
                guard let self else { return }
                
                self.userSession = user
                
                Task { @MainActor in
                    if user.isNotNil {
                        self.currentUser = await self.authService.fetchUser()
                        print("MDM current user setted, \(self.currentUser != nil)")
                    } else {
                        self.currentUser = nil
                    }
                    
                    print("MDM - [Login]: User: \(user.isNotNil), Anonymus: \(self.isAnonymous), result: \(self.isLoggedIn)")
                }
            }
        )
    }
}
