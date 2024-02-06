//
//  TrendingCollectionVC.swift
//  Trip Challenge
//
//  Created by Kate on 05/02/2024.
//

import UIKit

class TrendingCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView!
    private var trendingChallenges: [Challenge] = [] // Данные популярных челленджей

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        loadTrendingChallenges()
        let nib = UINib(nibName: "ChallengeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ChallengeCollectionViewCell")
    }

    private func setupCollectionView() {
        // Создание и настройка layout для UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        // Инициализация UICollectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

        // Регистрация кастомной ячейки
        collectionView.register(ChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCell")

        view.addSubview(collectionView)
    }

    private func loadTrendingChallenges() {
        // Загрузитm данные популярных челленджей
        // trendingChallenges = ...
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingChallenges.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as? ChallengeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let challenge = trendingChallenges[indexPath.row]
        cell.configure(with: challenge)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedChallenge = trendingChallenges[indexPath.row]

        // Создание экземпляра TrendingChallengesVC
        let TrendingChallengesVC = TrendingChallengesVC()

        // Передача выбранного челленджа в detailVC
        TrendingChallengesVC.challenge = selectedChallenge

        // Переход на detailVC
        navigationController?.pushViewController(TrendingChallengesVC, animated: true)
    }

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Адаптация размера ячейки к ширине экрана
        let width = collectionView.bounds.width - 20 // учитывая отступы
        let height: CGFloat = 200 // Высота ячейки
        return CGSize(width: width, height: height)
    }

    func showTrendingChallengeDetail(challenge: Challenge) {
        let trendingChallengeVC = TrendingChallengesVC()
        trendingChallengeVC.challenge = challenge

        // Проверка, встроен ли текущий контроллер в UINavigationController
        if let navigationController = navigationController {
            // Использование навигационного контроллера для перехода
            navigationController.pushViewController(trendingChallengeVC, animated: true)
        } else {
            present(trendingChallengeVC, animated: true)
        }
    }

    // MARK: UICollectionViewDelegate

    // Обработка выбора ячейки...
}
