////
////  PromoVC.swift
////  Trip Challenge
////
////  Created by Kate on 03/12/2023.
////
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
        layout.itemSize = CGSize(width: 300, height: 200)
        layout.scrollDirection = .vertical // Возможность горизонтального скроллинга
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Авторазмер
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PromoCell.self, forCellWithReuseIdentifier: "PromoCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }

    private func loadPromoData() {
        // Загрузка данных промоакций
        promoData = [
            Promo(title: "Февральская распродажа", description: "Распродажа зимних сувениров для ценителей искусства", discount: "20%", activeUntil: Date().addingTimeInterval(86400 * 30)),
            Promo(title: "Зимние скидки", description: "Специальные скидки до конца зимы на посещение музея", discount: "35%", activeUntil: Date().addingTimeInterval(86400 * 60)),
            Promo(title: "Акция для пар", description: "-15% скидка на билеты для пар", discount: "15%", activeUntil: Date().addingTimeInterval(86400 * 60)),
//            Promo(title: "Бесплатный понедельник", description: "Бесплатное посещение выставки только по понедельникам", discount: "15%", activeUntil: Date().addingTimeInterval(86400 * 60)),
        ]
        collectionView.reloadData()
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
}
