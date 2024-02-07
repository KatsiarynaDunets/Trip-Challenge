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
        // Add subviews to the cell's content view
        [challengeImageView, titleLabel, categoryLabel, poiCountLabel, ratingLabel, statusLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 12)

        categoryLabel.numberOfLines = 1
        categoryLabel.font = UIFont.systemFont(ofSize: 11)

        poiCountLabel.numberOfLines = 1
        poiCountLabel.font = UIFont.systemFont(ofSize: 11)

        ratingLabel.numberOfLines = 1
        ratingLabel.font = UIFont.systemFont(ofSize: 11)

        statusLabel.numberOfLines = 1
        statusLabel.font = UIFont.systemFont(ofSize: 11)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            challengeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            challengeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            challengeImageView.widthAnchor.constraint(equalToConstant: 50),
            challengeImageView.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: challengeImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            poiCountLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 2),
            poiCountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            poiCountLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            ratingLabel.topAnchor.constraint(equalTo: poiCountLabel.bottomAnchor, constant: 2),
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            statusLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 2),
            statusLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            statusLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    private func setupCellAppearance() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        challengeImageView.layer.cornerRadius = 5
        challengeImageView.clipsToBounds = true
    }
}
