//
//  Welcome.swift
//  Trip Challenge
//
//  Created by Kate on 13/11/2023.
//

import CoreLocation
import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet var startLbl: UILabel!
    @IBOutlet var welcomwLbl: UILabel!
    @IBOutlet var startBtn: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // locationManager.delegate = self
    }
    
    private func checkLocationAuthorizationStatus() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Show an alert letting the user know they need to enable Location Services
            showAlertToEnableLocationServices()
        case .authorizedWhenInUse, .authorizedAlways:
            performSegue(withIdentifier: "showMainVC", sender: self)
        @unknown default:
            fatalError("Unhandled authorization status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            performSegue(withIdentifier: "showMainVC", sender: self)
        }
    }
    
    private func showAlertToEnableLocationServices() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    @IBAction func startBtnTapped(_ sender: UIButton) {
        checkLocationAuthorizationStatus()
    }
}
