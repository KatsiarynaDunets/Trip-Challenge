//
//  MainVC.swift
//  Trip Challenge
//
//  Created by Kate on 19/11/2023.
//


    import UIKit
    import MapKit

class MainVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var trendingChallengesCollectionView: UICollectionView!
    @IBOutlet weak var nearYouChallengesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        fetchChallenges()
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
            // обновить интерфейс пользователя данными challenges
        case .failure(let error):
            // Обработка ошибки
            print("Error: \(error)")
            // показать сообщение об ошибке пользователю
        }
        
        // Обработчик нажатия на карточку challenge
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let selectedChallenge = // Получить challenge, соответствующий выбранной ячейке
//            performSegue(withIdentifier: "showChallengeDetail", sender: selectedChallenge)
//        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showChallengeDetail" {
                if let detailVC = segue.destination as? ChallengeDetailVC {
                    detailVC.challenge = sender as? Challenge // Challenge - это модель данных
                }
            }
        }
    }
}
