//
//  MainVC.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//

import UIKit
import MapKit
import CoreLocation

class MainVC: UIViewController, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var trendingChallengesCollectionView: UICollectionView!
    @IBOutlet weak var nearYouChallengesCollectionView: UICollectionView!
    @IBOutlet weak var citySelectionMenu: UIButton!
    
    var trendingChallenges: [Challenge] = []
    var nearYouChallenges: [Challenge] = []
    var userCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        fetchChallenges()
       
        // Request location permissions
//        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

               // Start updating location
               locationManager.startUpdatingLocation()
        // Start updating location
              locationManager.startUpdatingLocation()
    
        // Настройка collection views
        trendingChallengesCollectionView.delegate = self
        trendingChallengesCollectionView.dataSource = self
        
        nearYouChallengesCollectionView.delegate = self
        nearYouChallengesCollectionView.dataSource = self
    }
    
    // Инициализация ChallengeManager с примерными данными
    var challengeManager = ChallengeManager(challenges: [])
    
    // Настройка карты
    private func setupMapView() {
        mapView.delegate = self
        
        // Добавление отметки на карту
        let coordinate = CLLocationCoordinate2D(latitude: 50.06167308430535, longitude: 19.93778693361511)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Cracow"
        mapView.addAnnotation(annotation)
        
        // Установка региона для отображения Кракова
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    // Загрузка challenges
    private func fetchChallenges() {
        let result = challengeManager.getAllChallenges()
        switch result {
        case .success(let challenges):
            // Обработка успешного результата
            print("Challenges: \(challenges)")

            // Определите координаты пользователя (возможно, используя CLLocationManager или другой способ)
            guard let userCoordinate = locationManager.location?.coordinate else {
                // Handle the case when user location is not available
                return
            }

            // Разделите challenges на ближайшие и популярные
            trendingChallenges = Array(challenges.prefix(3)) // Выберите 3 последних челленджа
            nearYouChallenges = challenges.sorted(by: {
                let distanceToFirst = $0.calculateDistance(from: CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude))
                let distanceToSecond = $1.calculateDistance(from: CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude))
                return distanceToFirst < distanceToSecond
            })

            // Обновить интерфейс пользователя данными challenges!!!
            trendingChallengesCollectionView.reloadData()
            nearYouChallengesCollectionView.reloadData()
            
        case .failure(let error):
            // Обработка ошибки
            print("Error: \(error)")
            // Показать сообщение об ошибке пользователю
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingChallengesCollectionView {
            return trendingChallenges.count
        } else if collectionView == nearYouChallengesCollectionView {
            return nearYouChallenges.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == trendingChallengesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingChallengeCell", for: indexPath) as! ChallengeCollectionViewCell
            let challenge = trendingChallenges[indexPath.item]
            cell.configure(with: challenge)
            return cell
        } else if collectionView == nearYouChallengesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearYouChallengeCell", for: indexPath) as! ChallengeCollectionViewCell
            let challenge = nearYouChallenges[indexPath.item]
            cell.configure(with: challenge)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Обработка нажатия на карточку
        let selectedChallenge: Challenge
        if collectionView == trendingChallengesCollectionView {
            selectedChallenge = trendingChallenges[indexPath.item]
        } else {
            selectedChallenge = nearYouChallenges[indexPath.item]
        }
        performSegue(withIdentifier: "showChallengeDetail", sender: selectedChallenge)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Установите размеры карточек
        return CGSize(width: 150, height: 100)
    }
}
