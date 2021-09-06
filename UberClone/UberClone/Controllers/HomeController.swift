//
//  HomeController.swift
//  UberClone
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

    private let inputActivationView = LocationInputActivationView()

    private let locationInputView = LocationInputView()

    private let tableView = UITableView()

    private final let locationInputViewHeight: CGFloat = 200

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        enableLocationServices()

        inputActivationView.delegate = self
        locationInputView.delegate = self
    }

    //MARK: - Helpers
    func configureMainUI() {
        view.backgroundColor = .white

        addAllSubviews()
        addAllConstraints()
        configureMapView()
        configureTableView()

        inputActivationView.alpha = 0
        UIView.animate(withDuration: 1.5) { self.inputActivationView.alpha = 1 }

        locationInputView.alpha = 0
    }

    func configureMapView() {
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.identifier)
        tableView.rowHeight = 60
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)
        tableView.addShadow()
    }

    func toggleLocationInputView(opacity: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: {
            self.locationInputView.alpha = opacity
        }) { _ in
            if opacity == 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.frame.origin.y = self.view.frame.height
                })
                return
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            })
        }
    }

    func addAllSubviews() {
        let subviews = [mapView, inputActivationView, locationInputView, tableView]
        subviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func addAllConstraints() {
        let layout = view.safeAreaLayoutGuide

        let constraints = [
            inputActivationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputActivationView.topAnchor.constraint(equalTo: layout.topAnchor, constant: 32),
            inputActivationView.heightAnchor.constraint(equalToConstant: 50),
            inputActivationView.widthAnchor.constraint(equalToConstant: view.frame.width - 64),

            locationInputView.topAnchor.constraint(equalTo: view.topAnchor),
            locationInputView.leftAnchor.constraint(equalTo: view.leftAnchor),
            locationInputView.rightAnchor.constraint(equalTo: view.rightAnchor),
            locationInputView.heightAnchor.constraint(equalToConstant: locationInputViewHeight),

        ]

        NSLayoutConstraint.activate(constraints)
    }


    //MARK: - Actions
    @objc func signOut() {
        do {
            try Auth.auth().signOut()

            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LogInController())
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

extension HomeController: LocationInputActivationViewDelegate, LocationInputViewDelegate {
    func presentLocationInputView() {
        toggleLocationInputView(opacity: 1)
    }

    func dismissLocationInputView() {
        toggleLocationInputView(opacity: 0)
    }
}


extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier, for: indexPath) as? LocationCell else { return UITableViewCell() }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
