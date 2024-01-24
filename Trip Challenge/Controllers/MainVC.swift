//
//  MainVC.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//

import CoreData
import CoreLocation
import MapKit
import UIKit

class MainVC: UIViewController, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var trendingChallengesCollectionView: UICollectionView!
    @IBOutlet var nearYouChallengesCollectionView: UICollectionView!
    @IBOutlet var citySelectionMenu: UIButton!
    
    var trendingChallenges: [Challenge] = []
    var nearYouChallenges: [Challenge] = []
    var userCoordinate: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        fetchChallenges()
       
        
//        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // Запрос разрешения на использование геолокации

        // Start updating location
        locationManager.startUpdatingLocation()
    
        // Настройка collection views
        trendingChallengesCollectionView.delegate = self
        trendingChallengesCollectionView.dataSource = self
        
        nearYouChallengesCollectionView.delegate = self
        nearYouChallengesCollectionView.dataSource = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Текущее местоположение: \(location)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error)")
    }
    
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
        let context = self.getContext()
        let request = NSFetchRequest<Challenge>(entityName: "Challenge")
        do {
            let challenges = try context.fetch(request)

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

            DispatchQueue.main.async {
                self.trendingChallengesCollectionView.reloadData()
                self.nearYouChallengesCollectionView.reloadData()
            }
        } catch {
            print("Ошибка при загрузке данных: \(error)")
            // Показать сообщение об ошибке пользователю
        }
    }

    // Получение контекста Core Data
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChallengeDetail" {
            if let detailVC = segue.destination as? ChallengeDetailVC, let challenge = sender as? Challenge {
                detailVC.challenge = challenge
            }
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
        // размеры карточек
        return CGSize(width: 150, height: 100)
    }
}
