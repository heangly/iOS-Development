//
//  FeedConotroller.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//

import UIKit
import SDWebImage

class FeedController: UICollectionViewController {
    //MARK: - Properties
    private let viewModel = FeedViewModel()

    private var tweets = [Tweet]()

    var user: User? {
        didSet {
            configureLeftNavBar()
        }
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchTweets()
        configureUI()
        bindToViewModel()
    }

    //MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .white
        configureMidNavBar()
        configureLeftNavBar()
        configureCollectionViewCell()
    }

    func configureMidNavBar() {
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        navigationItem.titleView = imageView
    }

    func configureLeftNavBar() {
        guard let user = user else { return }
        let profileImage = UIImageView()
        profileImage.layer.cornerRadius = 32 / 2
        profileImage.clipsToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImage.sd_setImage(with: user.profileImageUrl)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }

    func configureCollectionViewCell() {
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.id)
    }

    func bindToViewModel() {
        viewModel.tweets.bind { [weak self] tweets in
            guard let tweets = tweets else { return }
            self?.tweets = tweets
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

}

//MARK: - CollectionView Cell Delegate / Datasource
extension FeedController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.id, for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }
        cell.configureTweetCell(with: tweets[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }

}


