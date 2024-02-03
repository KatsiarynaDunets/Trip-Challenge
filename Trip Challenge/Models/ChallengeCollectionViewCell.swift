//
//  ChallengeCell.swift
//  Trip Challenge
//
//  Created by Kate on 14/01/2024.
//

import UIKit

class ChallengeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel! // Добавленный UILabel для категории
    @IBOutlet weak var poiCountLabel: UILabel! // Добавленный UILabel для количества POI

    func configure(with challenge: Challenge) {
        titleLabel.text = challenge.challengeTitle
        categoryLabel.text = challenge.challengeCategory // Установка категории челленджа
        poiCountLabel.text = "POIs: \(challenge.pointsOfInterest.count)" // Установка количества POI

        // Загрузка изображения
        if let imageData = challenge.challengeImage, let image = UIImage(data: imageData) {
            challengeImageView.image = image
        } else {
            challengeImageView.image = UIImage(named: "defaultImage") // Загрузка изображения по умолчанию
        }
    }

    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
//        yourCollectionView.collectionViewLayout = layout
    }
}
