//
//  HomeController.swift
//  UberCloneTut
//
//  Created by Heang Ly on 9/4/21.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    //MARK: - Properties
    private let mapView = MKMapView()

    private let locationManager = CLLocationManager()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        enableLocationServices()
    }

    //MARK: - Helpers
    func configureMainUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.frame = view.frame

        configureMapView()
    }

    func configureMapView(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

    //MARK: - Actions
    @objc func signOut() {
        do {
            try Auth.auth().signOut()

            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }

        } catch {
            print("DEBUG: Error Sign Out -> \(error.localizedDescription)")
        }

    }
}


//MARK: - LocationServices
extension HomeController: CLLocationManagerDelegate {
    func enableLocationServices() {
        locationManager.delegate = self

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        case .restricted, .denied:
            print("DEBUG: denies...")

        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest

        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()

        default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.requestAlwaysAuthorization()
        }
    }


}
