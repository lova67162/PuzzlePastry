//
//  SettingsViewModel.swift
//  PuzzlePastry
//
//  Created by Андрей Сторожко on 27.08.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var id: String
    @Published var name: String
    @Published var email: String
    
    private var authService: AuthService = .init()

    init(id: String = "", name: String = "", email: String = "") {
        self.id = id
        self.name = name
        self.email = email
    }

    public static func == (lhs: SettingsViewModel, rhs: SettingsViewModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.email == rhs.email
    }
}

extension SettingsViewModel {
    func reloadDataSource() {
        let currentUser = SessionManager.shared.currentUser
        
        id = currentUser?.id ?? ""
        name = currentUser?.name ?? "NAME"
        email = currentUser?.email ?? "EMAIL"
    }
    
    func logOutButtonClicked() {
        let isSuccess = authService.logout()
        
        if isSuccess {
            SessionManager.shared.userSession = nil
            SessionManager.shared.currentUser = nil
            SessionManager.shared.isAnonymous = false
            clearDataState()
            print("Выход из системы выполнен")
        }
    }
        
    
    func deleteAccoountButtonClicked() {
        authService.deleteUserAccount { isSuccess in
            if isSuccess {
                SessionManager.shared.userSession = nil
                SessionManager.shared.currentUser = nil
                self.clearDataState()
                print("Аккаунт удален")
            } else {
                print("Ошибка при удалении аккаунта")
            }
        }
    }
    
    private func clearDataState() {
        let gameStorage: GameDomainModelStorage = .init()
        
        var games = gameStorage.read()
        
        for index in games.indices where index != 0 {
            games[index].isResolved = false
        }
        
        for game in games {
            gameStorage.store(item: game)
        }
    }
}
