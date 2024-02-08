//
//  ChallengeDetailVСV.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import CoreLocation
import UIKit

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
    
    // Функция для обновления расстояния до челленджа
    private func updateDistanceToChallenge() {
        guard let userLocation = locationManager.location, let challenge = challenge else { return }
        let challengeLocation = CLLocation(latitude: challenge.challengeLat, longitude: challenge.challengeLon)
        let distance = userLocation.distance(from: challengeLocation)
        distanceLabel.text = "Расстояние: \(Int(distance)) м"
    }
    
    // Обработка обновления местоположения пользователя
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateDistanceToChallenge()
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
        
        // Initialize and setup distanceLabel
        distanceLabel.font = UIFont.systemFont(ofSize: 16)
        distanceLabel.textColor = .white
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(distanceLabel)

        // Initialize and setup pointsLabel
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .white
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pointsLabel)

        // Setup ratingStarsView
        ratingStarsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingStarsView)

        // Initialize and setup descriptionLabel
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

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
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: challengeImageView.bottomAnchor, constant: 8),
            distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            pointsLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 4),
            pointsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pointsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            ratingStarsView.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 4),
            ratingStarsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ratingStarsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: ratingStarsView.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: discoverButton.topAnchor, constant: -20)
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
        if let imageData = challenge.challengeImage, let image = UIImage(data: imageData) {
            challengeImageView.image = image
        }
        
        // Обновление рейтинга
        pointsLabel.text = "Количество точек: \(challenge.challengeNumberOfPoints)"
        updateRating(Int(challenge.challengeRating))
    }
    
    
}
