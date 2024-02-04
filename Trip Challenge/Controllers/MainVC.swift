//
//  MainVC.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//

import CoreLocation
import MapKit
import RealmSwift
import UIKit

class MainVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var trendingChallengesCollectionView: UICollectionView!
    @IBOutlet var nearYouChallengesCollectionView: UICollectionView!
    @IBOutlet var citySelectionMenu: UIButton!
    
    var trendingChallenges: [Challenge] = []
    var nearYouChallenges: [Challenge] = []
    var userCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var challenges: [Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        trendingChallengesCollectionView.delegate = self
        trendingChallengesCollectionView.dataSource = self
        nearYouChallengesCollectionView.delegate = self
        nearYouChallengesCollectionView.dataSource = self
        
        fetchChallenges()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapVC", let destinationVC = segue.destination as? MapVC {
            destinationVC.challenges = challenges // Передача данных о челленджах
        }
    }
    
    // MARK: CLLocationManagerDelegate Methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userCoordinate = location.coordinate
            fetchChallenges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error)")
    }
    
    // Настройка карты
    private func setupMapView() {
        mapView.delegate = self
        
        // Добавление отметок на карту (замените координаты и информацию своими данными)
        for challenge in trendingChallenges + nearYouChallenges {
            let coordinate = CLLocationCoordinate2D(latitude: challenge.challengeLat, longitude: challenge.challengeLon)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = challenge.challengeTitle
            mapView.addAnnotation(annotation)
        }
        
        // Если местоположение пользователя доступно, центрируем карту на нем
        if let userCoordinate = userCoordinate {
            let region = MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func fetchChallenges() {
        let realm = try! Realm()
        
        // Загрузка всех челленджей
        let allChallenges = realm.objects(Challenge.self)
        
        // Для трендовых челленджей
        trendingChallenges = Array(allChallenges.sorted(byKeyPath: "challengeRating", ascending: false).prefix(5))
        
        // Для челленджей поблизости (используем логику определения близости, исходя из текущего местоположения пользователя)
        if let userLocation = locationManager.location {
            nearYouChallenges = Array(allChallenges.filter { challenge in
                let challengeLocation = CLLocation(latitude: challenge.challengeLat, longitude: challenge.challengeLon)
                return challengeLocation.distance(from: userLocation) < 500 // в радиусе 500м
            })
        } else {
            nearYouChallenges = []
        }
        
        // Обновление UI
        DispatchQueue.main.async {
            self.trendingChallengesCollectionView.reloadData()
            self.nearYouChallengesCollectionView.reloadData()
            self.updateMapAnnotations() // Если у вас есть функция для обновления аннотаций на карте
        }
    }
    
    private func updateMapAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        for challenge in trendingChallenges + nearYouChallenges {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: challenge.challengeLat, longitude: challenge.challengeLon)
            annotation.title = challenge.challengeTitle
            mapView.addAnnotation(annotation)
        }
    }
    
    //     MARK: - UICollectionViewDataSource
    
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
        // размеры карточек
        return CGSize(width: 150, height: 100)
    }
}

// import CoreData
// import CoreLocation
// import MapKit
// import UIKit
//
// class MainVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//
//
//
//    @IBOutlet var mapView: MKMapView!
//    @IBOutlet var trendingChallengesCollectionView: UICollectionView!
//    @IBOutlet var nearYouChallengesCollectionView: UICollectionView!
//    @IBOutlet var citySelectionMenu: UIButton!
//
//    var trendingChallenges: [Challenge] = []
//        var nearYouChallenges: [Challenge] = []
//        var userCoordinate: CLLocationCoordinate2D?
//        var locationManager = CLLocationManager()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            setupMapView()
////            fetchChallenges()
//
//            locationManager.delegate = self
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//
//            trendingChallengesCollectionView.delegate = self
//            trendingChallengesCollectionView.dataSource = self
//            nearYouChallengesCollectionView.delegate = self
//            nearYouChallengesCollectionView.dataSource = self
//        }
//
//
//    // MARK: CLLocationManagerDelegate Methods
//      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//          if let location = locations.last {
//              userCoordinate = location.coordinate
//              fetchChallenges()
//          }
//      }
//
//      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//          print("Ошибка получения местоположения: \(error)")
//      }
//
//    // Настройка карты
//    private func setupMapView() {
//        mapView.delegate = self
//
//        // Добавление отметки на карту
//        let coordinate = CLLocationCoordinate2D(latitude: 50.06167308430535, longitude: 19.93778693361511)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        annotation.title = "Cracow"
//        mapView.addAnnotation(annotation)
//
//        // Установка региона для отображения Кракова
//        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        mapView.setRegion(region, animated: true)
//    }
//
//    // Загрузка challenges
//    private func fetchChallenges() {
//        let context = self.getContext()
//        let request: NSFetchRequest<Challenge> = Challenge.fetchRequest()
//
//        do {
//            let challenges = try context.fetch(request)
//
//            // Если местоположение пользователя доступно, используйте его для фильтрации ближайших челленджей
//            if let userCoordinate = locationManager.location?.coordinate {
//                // Фильтрация челленджей по близости к текущему местоположению пользователя
//                nearYouChallenges = challenges.filter { challenge in
//                    let challengeLocation = CLLocation(latitude: challenge.challengeLat, longitude: challenge.challengeLon)
//                    return challengeLocation.distance(from: CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)) < 10000 // например, в радиусе 10 км
//                }
//
//                // Сортировка ближайших челленджей по расстоянию
//                nearYouChallenges.sort { (challenge1, challenge2) -> Bool in
//                    let loc1 = CLLocation(latitude: challenge1.challengeLat, longitude: challenge1.challengeLon)
//                    let loc2 = CLLocation(latitude: challenge2.challengeLat, longitude: challenge2.challengeLon)
//                    return loc1.distance(from: CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)) <
//                        loc2.distance(from: CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude))
//                }
//            } else {
//                nearYouChallenges = []
//            }
//
//            // Выборка трендовых челленджей, например, на основе рейтинга или других критериев
//            trendingChallenges = challenges.sorted { $0.challengeRating > $1.challengeRating }.prefix(3) // Топ-3 челленджа по рейтингу
//
//            DispatchQueue.main.async {
//                self.trendingChallengesCollectionView.reloadData()
//                self.nearYouChallengesCollectionView.reloadData()
//            }
//        } catch {
//            print("Ошибка при загрузке данных: \(error)")
//            // Обработка ошибок и возможное отображение сообщения пользователю
//        }
//    }
//
//    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showChallengeDetail" {
//            if let detailVC = segue.destination as? ChallengeDetailVC, let challenges = sender as? Challenge {
//                detailVC.challenge = challenges
//            }
//        }
//    }
//
//    // MARK: - UICollectionViewDataSource
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == trendingChallengesCollectionView {
//            return trendingChallenges.count
//        } else if collectionView == nearYouChallengesCollectionView {
//            return nearYouChallenges.count
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == trendingChallengesCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingChallengeCell", for: indexPath) as! ChallengeCollectionViewCell
//            let challenge = trendingChallenges[indexPath.item]
//            cell.configure(with: challenge)
//            return cell
//        } else if collectionView == nearYouChallengesCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearYouChallengeCell", for: indexPath) as! ChallengeCollectionViewCell
//            let challenge = nearYouChallenges[indexPath.item]
//            cell.configure(with: challenge)
//            return cell
//        }
//
//        return UICollectionViewCell()
//    }
//
//    // MARK: - UICollectionViewDelegate
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // Обработка нажатия на карточку
//        let selectedChallenge: Challenges
//        if collectionView == trendingChallengesCollectionView {
//            selectedChallenge = trendingChallenges[indexPath.item]
//        } else {
//            selectedChallenge = nearYouChallenges[indexPath.item]
//        }
//        performSegue(withIdentifier: "showChallengeDetail", sender: selectedChallenge)
//    }
//
//    // MARK: - UICollectionViewDelegateFlowLayout
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // размеры карточек
//        return CGSize(width: 150, height: 100)
//    }
// }
