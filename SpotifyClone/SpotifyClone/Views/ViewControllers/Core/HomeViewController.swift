//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
        fetchData()
    }

    func configureMainUI() {
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
    }

    private func fetchData() {
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecommendation(genres: seeds) { _ in
                    
                }
                break
            case .failure(let error):
                break
            }
        }
    }

    @objc func didTapSettings() {
        let vc = SettingViewsController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

}

