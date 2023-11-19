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
        @IBOutlet weak var routesButton: UIButton!

        override func viewDidLoad() {
            super.viewDidLoad()

            setupMapView()
            setupRoutesButton()
        }

        // Настройка карты
        private func setupMapView() {
            mapView.delegate = self

            // Добавление отметки на карту (замени на свои координаты)
            let coordinate = CLLocationCoordinate2D(latitude: 50.06167308430535, longitude: 19.93778693361511)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Cracow"
            mapView.addAnnotation(annotation)

            // Установка региона для отображения Кракова
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }

        // Настройка кнопки "Популярные маршруты"
        private func setupRoutesButton() {
            routesButton.layer.cornerRadius = 8.0
            routesButton.addTarget(self, action: #selector(showPopularRoutes), for: .touchUpInside)
        }

        // Обработка нажатия кнопки "Популярные маршруты"
        @objc private func showPopularRoutes() {
             performSegue(withIdentifier: "ShowPopularRoutesSegue", sender: self)
             }
//  метод для подготовки данных перед переходом
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowPopularRoutesSegue" {
            
            // if let popularRoutesVC = segue.destination as? PopularRoutesViewController {
             // popularRoutesVC.propertyName = someValue
             }
             }
             }
            }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
