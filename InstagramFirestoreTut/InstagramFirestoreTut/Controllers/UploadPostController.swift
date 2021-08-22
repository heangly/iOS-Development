//
//  UploadPostController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/21/21.
//

import UIKit

class UploadPostController: UIViewController {
    //MARK: - Properties
    private let photoImageView: UIImageView =  {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 19
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(didTapDone))
        
        handleAddSubViewsAndConstraint()
    }
    
    func checkMaxLength(_ textView: UITextView){
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }
    
    //MARK: - Actions
    @objc func didTapCancel(){
        dismiss(animated: true)
    }
    
    @objc func didTapDone(){
        print("Did Tap Dne")
    }
    
    //MARK: - Constraints
    func handleAddSubViewsAndConstraint(){
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
