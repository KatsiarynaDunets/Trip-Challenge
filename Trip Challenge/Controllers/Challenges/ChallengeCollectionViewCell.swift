//
//  ChallengeCollectionViewCell.swift
//  Trip Challenge
//
//  Created by Kate on 05/02/2024.
//

import UIKit

class ChallengeCollectionViewCell: UICollectionViewCell {
    var challengeImageView = UIImageView()
    var titleLabel = UILabel()
    var categoryLabel = UILabel()
    var poiCountLabel = UILabel()
    var ratingLabel = UILabel()
    var statusLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        setupCellAppearance()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with challenge: Challenge) {
        titleLabel.text = challenge.challengeTitle
        categoryLabel.text = challenge.challengeCategory
        poiCountLabel.text = "POIs: \(challenge.pointsOfInterest.count)"
        ratingLabel.text = "⭐️ \(challenge.challengeRating)"
        statusLabel.text = challenge.challengeStatus

        if let imageData = challenge.challengeImage, let image = UIImage(data: imageData) {
            challengeImageView.image = image
        } else {
            challengeImageView.image = UIImage(named: "defaultImage") // default image if imageData is not available
        }
    }

    private func setupSubviews() {
        contentView.addSubview(challengeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(poiCountLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(statusLabel)

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left

        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .left

        poiCountLabel.numberOfLines = 0
        poiCountLabel.textAlignment = .left

        ratingLabel.numberOfLines = 0
        ratingLabel.textAlignment = .left

        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .left
    }

    private func setupConstraints() {
        challengeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        poiCountLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            challengeImageView.topAnchor.constraint(equalTo: topAnchor),
            challengeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            challengeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            challengeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),

            titleLabel.topAnchor.constraint(equalTo: challengeImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            poiCountLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            poiCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            poiCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            ratingLabel.topAnchor.constraint(equalTo: poiCountLabel.bottomAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            statusLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    private func setupCellAppearance() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        challengeImageView.layer.cornerRadius = 10
        challengeImageView.clipsToBounds = true
    }
}
