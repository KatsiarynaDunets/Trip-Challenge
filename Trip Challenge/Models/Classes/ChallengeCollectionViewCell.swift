//
//  ChallengeCell.swift
//  Trip Challenge
//
//  Created by Kate on 14/01/2024.
//

import UIKit
import CoreData

class ChallengeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(with challenge: Challenge) {
        // Настройка элементов ячейки на основе данных о челлендже
        titleLabel.text = challenge.title
        descriptionLabel.text = challenge.description
        
        // Загрузка изображения
        
    }
    
//    let layout = UICollectionViewFlowLayout()
//    layout.itemSize = CGSize(width: 150, height: 150)
//    layout.minimumInteritemSpacing = 10
//    layout.minimumLineSpacing = 10
//    yourCollectionView.collectionViewLayout = layout
}
