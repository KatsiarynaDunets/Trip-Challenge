//
//  ChallengeDetailVСV.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import UIKit

class ChallengeDetailVC: UIViewController {

        var challenge: Challenge? // Challenge - модель данных

        private let titleLabel = UILabel()
        private let descriptionLabel = UILabel()
        private let challengeImageView = UIImageView()
        private let acceptButton = UIButton()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupLayout()
            configureView()
        }

        private func setupLayout() {
            // Настройка titleLabel, descriptionLabel, challengeImageView и acceptButton
            // Добавьте их как subview и настройте constraints
        }

        private func configureView() {
            guard let challenge = challenge else { return }

            titleLabel.text = challenge.title
            descriptionLabel.text = challenge.description
            // Загрузите изображение в challengeImageView, если оно есть
            // Настройте acceptButton
        }

        // Действие для acceptButton
        @objc private func acceptChallenge() {
            // Реализуйте логику принятия challenge
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


