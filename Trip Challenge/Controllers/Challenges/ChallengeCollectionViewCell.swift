//
//  ChallengeCell.swift
//  Trip Challenge
//
//  Created by Kate on 14/01/2024.
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
            challengeImageView.image = UIImage(named: "defaultImage")
        }
    }

    private func setupSubviews() {
        addSubview(challengeImageView)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(poiCountLabel)
        addSubview(ratingLabel)
        addSubview(statusLabel)

        // Настройка дополнительных свойств для элементов UI
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        // не забыть сюда еще добавить для других элементов!!!
    }

    private func setupConstraints() {
        challengeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        poiCountLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        // Констрейнты для categoryLabel
            NSLayoutConstraint.activate([
                categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])

            // Констрейнты для poiCountLabel
            NSLayoutConstraint.activate([
                poiCountLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
                poiCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                poiCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])

            // Констрейнты для ratingLabel
            NSLayoutConstraint.activate([
                ratingLabel.topAnchor.constraint(equalTo: poiCountLabel.bottomAnchor, constant: 4),
                ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])

            // Констрейнты для statusLabel
            NSLayoutConstraint.activate([
                statusLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),
                statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8) // отступ от нижней границы ячейки
            ])
    }

    private func setupCellAppearance() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        challengeImageView.layer.cornerRadius = 10
        challengeImageView.clipsToBounds = true
    }
}
