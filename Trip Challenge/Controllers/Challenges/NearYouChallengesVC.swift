//
//  NearYouChallengesVC.swift
//  Trip Challenge
//
//  Created by Kate on 05/02/2024.
//

import CoreLocation
import UIKit
import RealmSwift

class NearYouChallengesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView!
    private var nearYouChallenges: [Challenge] = [] // Array to hold challenges
    private var locationManager: CLLocationManager! // Declare locationManager
    private var databaseManager = DatabaseManager() // Initialize databaseManager

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager() // Setup locationManager
        setupCollectionView()
        loadNearYouChallenges()
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

    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate
        locationManager.requestWhenInUseAuthorization() // Request location permission
        locationManager.startUpdatingLocation()
    }

    private func loadNearYouChallenges() {
        // Ensure that the location manager has the current location
        if let userLocation = locationManager.location {
            // Fetch challenges near the user's location
            nearYouChallenges = databaseManager.getChallengesNear(location: userLocation)
        } else {
            // Handle the case where location is not available
            nearYouChallenges = []
            // Optionally, prompt the user to enable location services
        }

//         Reload the collection view with the fetched data
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearYouChallenges.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as? ChallengeCollectionViewCell else {
            fatalError("Unable to dequeue ChallengeCollectionViewCell")
        }

        let challenge = nearYouChallenges[indexPath.row]
        cell.configure(with: challenge)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedChallenge = nearYouChallenges[indexPath.row]
        let detailVC = ChallengeDetailVC()
        detailVC.challenge = selectedChallenge
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
}
