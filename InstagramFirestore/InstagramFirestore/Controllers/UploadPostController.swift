//
//  uploadPostController.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/21/21.
//

import UIKit
import Firebase

protocol UploadPostControllerDelegate: class {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    //MARK: - Properties
    weak var delegate: UploadPostControllerDelegate?

    private var user: User?

    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }

    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()

    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.placeholderText = "Enter caption..."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        return tv
    }()

    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchCurrentUser()
    }

    //MARK: - API
    func fetchCurrentUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }

    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(didTapDone))

        handleAddSubView()
    }

    func checkMaxLength(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }



    //MARK: - Actions
    @objc func didTapCancel() {
        dismiss(animated: true)
    }

    @objc func didTapDone() {
        guard let image = selectedImage else { return }
        guard let caption = captionTextView.text else { return }
        guard let user = user else { return }
        showLoader(true)
        PostService.uploadPost(caption: caption, image: image, user: user) { error in
            self.showLoader(false)

            if let error = error {
                print("DEBUG: Failed to upload post with error: \(error.localizedDescription)")
                return
            }

            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }

    func handleAddSubView() {
        [photoImageView, captionTextView, characterCountLabel].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 180),
            photoImageView.heightAnchor.constraint(equalToConstant: 180),
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            captionTextView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            captionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            captionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            captionTextView.heightAnchor.constraint(equalToConstant: 64),

            characterCountLabel.bottomAnchor.constraint(equalTo: captionTextView.bottomAnchor),
            characterCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),

            ])
    }
}


//MARK: - UITextFieldDelegate
extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}

