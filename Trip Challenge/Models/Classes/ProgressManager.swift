//
//  ProgressManager.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//

import Foundation
class ProgressManager {
    var progressList: [Progress]

    init(progressList: [Progress]) {
        self.progressList = progressList
    }

    func markChallengeAsCompleted(userId: Int, challengeId: Int) {
        if let index = progressList.firstIndex(where: { $0.userId == userId && $0.challengeId == challengeId }) {
            progressList[index].isCompleted = true
        } else {
            let newProgress = Progress(userId: userId, challengeId: challengeId, isCompleted: true)
            progressList.append(newProgress)
        }
    }
}

// Пример использования
let progressManager = ProgressManager(progressList: [])
//progressManager.markChallengeAsCompleted(userId: 1, challengeId: 1)
////print(progressManager.progressList)
