//
//  ViewController.swift
//  Trip Challenge
//
//  Created by Kate on 13/11/2023.
//
import UIKit

// Предполагаем, что Challenge и AppError уже определены где-то в вашем коде.

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
var challengeManager = ChallengeManager(challenges: [])
let result = challengeManager.getAllChallenges()


