//
//  PopularRoutesVC.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//

import UIKit

class TrendingChallengesVC: UIViewController {
    var challengeImageView = UIImageView()
    var titleLabel = UILabel()
    var categoryLabel = UILabel()
    var ratingLabel = UILabel()
    var poiCountLabel = UILabel()
    var descriptionLabel = UILabel()

    var challenge: Challenge?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureView()
    }

    private func setupViews() {
        view.addSubview(challengeImageView)
        view.addSubview(titleLabel)
        view.addSubview(categoryLabel)
        view.addSubview(ratingLabel)
        view.addSubview(poiCountLabel)
        view.addSubview(descriptionLabel)

        challengeImageView.contentMode = .scaleAspectFill
        challengeImageView.clipsToBounds = true

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        categoryLabel.textAlignment = .left

        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textAlignment = .right

        poiCountLabel.font = UIFont.systemFont(ofSize: 16)
        poiCountLabel.textAlignment = .right

        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
    }

    private func setupConstraints() {
        challengeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        poiCountLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            challengeImageView.topAnchor.constraint(equalTo: view.topAnchor),
            challengeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            challengeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            challengeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),

            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),

            poiCountLabel.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            poiCountLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),

            descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func configureView() {
        guard let challenge = challenge else { return }

        titleLabel.text = challenge.challengeTitle
        categoryLabel.text = challenge.challengeCategory
        ratingLabel.text = "⭐️ \(challenge.challengeRating)"
        poiCountLabel.text = "POIs: \(challenge.pointsOfInterest.count)"
        descriptionLabel.text = challenge.challengeDescription

        if let imageData = challenge.challengeImage, let image = UIImage(data: imageData) {
            challengeImageView.image = image
        } else {
            challengeImageView.image = UIImage(named: "defaultImage")
        }
    }
}
