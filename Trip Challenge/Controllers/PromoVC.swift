//
//  PromoVC.swift
//  Trip Challenge
//
//  Created by Kate on 03/12/2023.
//

import UIKit

class PromoVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

        var collectionView: UICollectionView!
        var promoData: [Promo] = [] // Promo is a custom model representing each promo

        override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            loadPromoData()
        }

        private func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 300, height: 200) // Adjust size as needed
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(PromoCell.self, forCellWithReuseIdentifier: "PromoCell")
            collectionView.backgroundColor = .white
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        }

    private func loadPromoData() {
        // Example data - replace with real data loading logic
        promoData = [
            Promo(title: "Xmas Sale", description: "Get 20% off on all Christmas items!", discount: "20%", activeUntil: Date().addingTimeInterval(86400 * 30)), // Active for 30 days
            Promo(title: "Winter Special", description: "Special discounts on winter gear.", discount: "15%", activeUntil: Date().addingTimeInterval(86400 * 60)) // Active for 60 days
        ]
    }


        // MARK: - UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return promoData.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCell", for: indexPath) as? PromoCell else {
                return UICollectionViewCell()
            }
            let promo = promoData[indexPath.row]
            cell.configure(with: promo)
            return cell
        }

        // MARK: - UICollectionViewDelegate
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let promo = promoData[indexPath.row]
            // Handle promo code viewing and invalidation logic here
        }
}
