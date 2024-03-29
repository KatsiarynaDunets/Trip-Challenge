//
//  MainVC.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.

import CoreLocation
import MapKit
import RealmSwift
import UIKit

class MainVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var trendingChallengesCollectionView: UICollectionView!
    @IBOutlet var nearYouChallengesCollectionView: UICollectionView!
    @IBOutlet var citySelectionMenu: UIButton!
    
    @IBOutlet var trendingChallengesBtn: UIButton!
    @IBOutlet var nearYouChallengesBtn: UIButton!
    
    var trendingChallenges: [Challenge] = []
    var nearYouChallenges: [Challenge] = []
    var userCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var challenges: [Challenge] = []
    var databaseManager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        loadDataIfNeeded()
        loadChallenges()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        fetchChallenges()
        updateMapAnnotations()
        setupCollectionViews()
        handleLocationAccessDenied()
        trendingChallengesButtonTapped(trendingChallengesBtn)
        trendingChallengesCollectionView.register(ChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCollectionViewCell")
        nearYouChallengesCollectionView.register(ChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCollectionViewCell")
    }
    
    private func setupCollectionViews() {
        trendingChallengesCollectionView.delegate = self
        trendingChallengesCollectionView.dataSource = self
        nearYouChallengesCollectionView.delegate = self
        nearYouChallengesCollectionView.dataSource = self
        
        // Register the custom cell class
        trendingChallengesCollectionView.register(ChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCollectionViewCell")
        nearYouChallengesCollectionView.register(ChallengeCollectionViewCell.self, forCellWithReuseIdentifier: "ChallengeCollectionViewCell")
    }
    
    private func loadDataIfNeeded() {
        let realm = try! Realm()
        
        // Проверка наличия данных POI
        if realm.objects(POI.self).isEmpty {
            databaseManager.addPOIs()
        }
        
        // Проверка наличия данных челленджей
        if realm.objects(Challenge.self).isEmpty {
            databaseManager.createAndAddChallenges()
        }
        
        // После добавления данных, загрузить их для отображения
        loadChallenges()
    }
    
    // Функция для загрузки челленджей
    private func loadChallenges() {
        // Загрузка данных челленджей из базы данных для отображения на экране
        trendingChallenges = databaseManager.getTrendingChallenges()
        if let userLocation = locationManager.location {
            nearYouChallenges = databaseManager.getChallengesNear(location: userLocation)
        } else {
            nearYouChallenges = []
        }
        
        // Обновление интерфейса
        DispatchQueue.main.async {
            self.trendingChallengesCollectionView.reloadData()
            self.nearYouChallengesCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapVC", let destinationVC = segue.destination as? MapVC {
            destinationVC.challenges = challenges // Передача данных о челленджах
        }
    }
    
    // MARK: CLLocationManagerDelegate Methods
    
    //    CLLocationManagerDelegate методы для обработки ответа пользователя
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Разрешение получено, можно начинать использовать геолокацию
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            //             Пользователь отказал в доступе или доступ ограничен (например, родительским контролем)
            handleLocationAccessDenied()
        @unknown default:
            // Неизвестный статус, полезно для будущих версий iOS
            break
        }
    }
    
    private func handleLocationAccessDenied() {
        // Функция для обработки отказа в доступе к геолокации
        let alert = UIAlertController(title: "Доступ к геолокации запрещен", message: "Пожалуйста, включите доступ к геолокации в настройках, чтобы использовать все функции приложения.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Открыть настройки", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
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
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        // Добавление отметки на карту
        let coordinate = CLLocationCoordinate2D(latitude: 50.06167308430535, longitude: 19.93778693361511)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Краков"
        mapView.addAnnotation(annotation)
        
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
        do {
            let realm = try Realm()
            
            // Загрузка всех челленджей
            let allChallenges = realm.objects(Challenge.self)
            
            // Для трендовых челленджей
            trendingChallenges = Array(allChallenges.sorted(byKeyPath: "challengeRating", ascending: false).prefix(5))
            
            // Для челленджей поблизости
            if let userLocation = locationManager.location {
                nearYouChallenges = Array(allChallenges.filter { challenge in
                    let challengeLocation = CLLocation(latitude: challenge.challengeLat, longitude: challenge.challengeLon)
                    return challengeLocation.distance(from: userLocation) < 500000000 // в радиусе 50 км
                })
            } else {
                nearYouChallenges = []
            }
            
            // Обновление UI
            DispatchQueue.main.async {
                self.trendingChallengesCollectionView.reloadData()
                self.nearYouChallengesCollectionView.reloadData()
                // self.updateMapAnnotations()
            }
        } catch {
            print("Ошибка при загрузке данных из Realm: \(error)")
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCollectionViewCell", for: indexPath) as? ChallengeCollectionViewCell else {
                fatalError("Unable to dequeue ChallengeCollectionViewCell")
            }
            let challenge = trendingChallenges[indexPath.item]
            cell.configure(with: challenge)
            return cell
        } else if collectionView == nearYouChallengesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCollectionViewCell", for: indexPath) as! ChallengeCollectionViewCell
            let challenge = nearYouChallenges[indexPath.item]
            cell.configure(with: challenge)
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDelegate

    @IBAction func trendingChallengesButtonTapped(_ sender: UIButton) {
        let trendingVC = TrendingCollectionVC()
        navigationController?.pushViewController(trendingVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedChallenge: Challenge
        if collectionView == trendingChallengesCollectionView {
            selectedChallenge = trendingChallenges[indexPath.item]
        } else {
            selectedChallenge = nearYouChallenges[indexPath.item]
        }
        let trendingChallengesVC = TrendingChallengesVC()
        trendingChallengesVC.challenge = selectedChallenge
        navigationController?.pushViewController(trendingChallengesVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // размеры карточек
        return CGSize(width: 150, height: 100)
    }
    
}
