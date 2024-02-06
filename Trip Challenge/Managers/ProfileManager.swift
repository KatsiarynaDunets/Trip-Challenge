//
//  ProfileManager.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//
import UIKit

class ProfileManager {
    var users: [User]

    init(users: [User]) {
        self.users = users
    }

    func getUserProfile(userId: Int) -> Result<User, AppError> {
        guard let user = users.first(where: { $0.userId == userId }) else {
            return .failure(.userNotFound)
        }
        return .success(user)
    }
}

//// Пример использования с обработкой ошибок
// let user1 = User(userId: 1, username: "tourist123", achievements: ["Explorer", "Historian"])
// let user2 = User(userId: 2, username: "adventureGirl", achievements: ["Adventurer"])
// let profileManager = ProfileManager(users: [user1, user2])
// if case let Result.failure(error) = profileManager.getUserProfile(userId: 3) {
//    print("Error: \(error)")
