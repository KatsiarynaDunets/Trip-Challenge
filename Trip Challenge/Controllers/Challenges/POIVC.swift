////
////  POIVC.swift
////  Trip Challenge
////
////  Created by Kate on 31/01/2024.
////

import MapKit
import UIKit

class POIVC: UIViewController {
    let databaseManager = DatabaseManager()

    private let poiImageView = UIImageView()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let locationLabel = UILabel()
    private let promoLabel = UILabel()
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
//        configureView()
    }

    private func setupLayout() {
        // Настройка интерфейса, включая расположение и стилизацию компонентов
        poiImageView.contentMode = .scaleAspectFill
        poiImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiImageView)

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryLabel)

        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)

        promoLabel.font = UIFont.systemFont(ofSize: 14)
        promoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(promoLabel)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)

        // Настройка constraints

        NSLayoutConstraint.activate([
            // Constraints для poiImageView
            poiImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            poiImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            poiImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            poiImageView.heightAnchor.constraint(equalToConstant: 200), // Высота может быть изменена

            // Constraints для titleLabel
            titleLabel.topAnchor.constraint(equalTo: poiImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Constraints для categoryLabel
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // Constraints для descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // Constraints для locationLabel
            locationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // Constraints для promoLabel
            promoLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            promoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            promoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            // Constraints для mapView
            mapView.topAnchor.constraint(equalTo: promoLabel.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

//
//    private func configureView() {
//       guard let poi = poi else { return }
//
//        titleLabel.text = poi.poiTitle
//        categoryLabel.text = poi.poiCategory
//        descriptionLabel.text = poi.poiDescription
//        locationLabel.text = "Местоположение: \(poi.poiLocation ?? "Неизвестно")"
//        promoLabel.text = poi.poiPromo ? "Промо активно" : "Нет промо"
//
//        if let imageData = poi.poiImage, let image = UIImage(data: imageData) {
//            poiImageView.image = image
//        }
//
//        setupMapView(latitude: poi.poiLat, longitude: poi.poiLon)
//    }

    private func setupMapView(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}
