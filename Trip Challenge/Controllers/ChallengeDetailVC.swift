//
//  ChallengeDetailVСV.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import UIKit
import CoreLocation

class ChallengeDetailVC: UIViewController, CLLocationManagerDelegate {
    var challenge: Challenge? // Challenge - модель данных

    private let challengeImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let distanceLabel = UILabel()
    private let pointsLabel = UILabel()
    private let ratingStarsView = UIView() // Для отображения звезд рейтинга
    private let descriptionLabel = UILabel()
    private let discoverButton = UIButton()
    private var ratingStars: [UIImageView] = []
    private let maxRating = 5
    private let locationManager = CLLocationManager()


       override func viewDidLoad() {
           super.viewDidLoad()
           setupLayout()
           configureView()
           configureLocationManager()
       }

       private func configureLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
       }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           updateDistanceToChallenge()
       }

    private func updateDistanceToChallenge() {
           guard let userLocation = locationManager.location, let challenge = challenge else { return }
           let distance = challenge.calculateDistanceToNearestPoint(from: userLocation)
           if let distance = distance {
               print("\(distance) m")
               distanceLabel.text = "Расстояние: \(distance) м"
           } else {
               print("Точки маршрута отсутствуют")
           }
       }

    private func setupLayout() {
        // Настройка challengeImageView
        challengeImageView.contentMode = .scaleAspectFill
        challengeImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(challengeImageView)

        // Настройка градиента
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        view.layer.addSublayer(gradientLayer)

        // Настройка titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Настройка categoryLabel и других лейблов
        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        categoryLabel.textColor = .white
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryLabel)

        // Настройка рейтинга
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.distribution = .fillEqually
        starStackView.spacing = 5
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starStackView)

        for _ in 0 ..< maxRating {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageView.image = UIImage(systemName: "star") // используем SF Symbols
            starImageView.tintColor = .systemMint // Выберите подходящий цвет
            starImageView.isUserInteractionEnabled = true
            starStackView.addArrangedSubview(starImageView)
            ratingStars.append(starImageView)

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
            starImageView.addGestureRecognizer(tapGesture)
        }
        NSLayoutConstraint.activate([
            starStackView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -12),
            starStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            starStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            starStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc private func starTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedStar = sender.view as? UIImageView else { return }
        let selectedRating = ratingStars.firstIndex(of: tappedStar)! + 1
        updateRating(selectedRating)
    }

    private func updateRating(_ rating: Int) {
        for (index, star) in ratingStars.enumerated() {
            star.image = index < rating ? UIImage(named: "star_filled") : UIImage(named: "star_empty") // Замените на ваши изображения
        }
     
//        challenge?.rating = poiRating
        // ... Добавить distanceLabel, pointsLabel, ratingStarsView и descriptionLabel

        // Настройка Discover Button
        discoverButton.setTitle("Discover", for: .normal)
        discoverButton.backgroundColor = .systemMint
        discoverButton.layer.cornerRadius = 25
        discoverButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(discoverButton)

        // Настройка constraints
        NSLayoutConstraint.activate([
            challengeImageView.topAnchor.constraint(equalTo: view.topAnchor),
            challengeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            challengeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            challengeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            categoryLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -12),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // ... Добавьте constraints для distanceLabel, pointsLabel, ratingStarsView и descriptionLabel

            discoverButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            discoverButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            discoverButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            discoverButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureView() {
        guard let challenge = challenge else { return }

        titleLabel.text = challenge.challengeTitle
        categoryLabel.text = challenge.challengeCategory
        descriptionLabel.text = challenge.challengeDescription

        // Установка изображения
    
        let image = UIImage(data: challenge.challengeImage)
           challengeImageView.image = image


        // есть метод для расчета расстояния до челленджа
        // distanceLabel.text = "Расстояние: \(расчетное_расстояние)"

        pointsLabel.text = "Количество точек: \(challenge.challengeNumberOfPoints)"
        updateRating(Int(challenge.challengeRating)) // Обновление рейтинга
    }

    // categoryLabel.text = challenge.category
    // ... Установить значения для distanceLabel, pointsLabel, ratingStarsView и descriptionLabel

    // Установить изображение для challengeImageView, например challengeImageView.image = UIImage(data: challenge.imageData)

    // Настройка рейтинга звезд (ratingStarsView) в зависимости от рейтинга challenge
}

private func acceptChallenge() {
    guard let challenge = self.challenge else { return }
    // Пример: challenge.isAccepted = true
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        try context.save()
    } catch {
        print("Ошибка сохранения изменений: \(error)")
    }
}

class ChallengesViewController: UIViewController {
    
    var challenges: [Challenge] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        challenges = DataManager.shared.fetchAllChallenges()
        // Отобразить челленджи...
    }

    func showChallengeDetails(_ challenge: Challenge) {
        let pois = DataManager.shared.fetchPointsOfInterest(for: challenge)
        // Показать детали челленджа и точек интереса...
    }

    func startChallenge(_ challenge: Challenge) {
        DataManager.shared.activateChallenge(challenge)
        // Обновить UI и начать челлендж...
    }

    func markPOIVisited(_ poi: PointsOfInterest) {
        DataManager.shared.markPointOfInterestAsVisited(poi)
        // Обновить UI для отмеченной точки интереса...
    }
}
