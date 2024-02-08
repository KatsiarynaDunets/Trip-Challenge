//
//  NearYouChallengesCollectionVC.swift
//  Trip Challenge
//
//  Created by Kate on 05/02/2024.
//

import UIKit

class NearYouChallengesCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView!
    private var nearYouChallenges: [Challenge] = [] // Данные челленджей поблизости

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        loadNearYouChallenges()
        collectionView.register(ChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCell")
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
    }

    private func loadNearYouChallenges() {
        // Загрузка данных челленджей поблизости
        // nearYouChallenges = ...
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearYouChallenges.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as? ChallengeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let challenge = nearYouChallenges[indexPath.row]
        cell.configure(with: challenge)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedChallenge = nearYouChallenges[indexPath.row]
        let nearYouChallengesVC = ChallengeDetailVC()
        nearYouChallengesVC.challenge = selectedChallenge
        navigationController?.pushViewController(nearYouChallengesVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
}

// MARK: UICollectionViewDelegate

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
 }

 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
 }

 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

 }
 */
