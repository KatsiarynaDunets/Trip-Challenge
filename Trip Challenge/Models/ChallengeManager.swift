//
//  ViewController.swift
//  Trip Challenge
//
//  Created by Kate on 13/11/2023.
//

import UIKit

class ChallengeManager {
    var challenges: [Challenge]

    init(challenges: [Challenge]) {
        self.challenges = challenges
    }

    func getAllChallenges() -> Result<[Challenge], AppError> {
        guard !challenges.isEmpty else {
            return .failure(.challengeNotFound)
        }
        return .success(challenges)
    }
}

// Пример использования с обработкой ошибок
let challengeManager = ChallengeManager(challenges: [])
if case let Result.failure(error) = challengeManager.getAllChallenges() {
    print("Error: \(error)")
}
