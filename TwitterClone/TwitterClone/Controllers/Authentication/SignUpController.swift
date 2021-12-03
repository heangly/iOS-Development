//
//  SignUpController.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/18/21.
//


import UIKit

class SignUpController: UIViewController {
    //MARK: - Properties
    private let signUpView = SignUpView()

    private let imagePicker = UIImagePickerController()

    private var viewModel: SignUpViewModel?

    //MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        signUpView.delegate = self
        viewModel = SignUpViewModel(view: signUpView)
    }

}

//MARK: - SignUpViewDelegte
extension SignUpController: SignUpViewDelegte {
    func didTapPlusPhotoButtonTapped(_ signUpView: SignUpView) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }

    func didTapAlreadyHaveAccountButton(_ signUpView: SignUpView) {
        navigationController?.popViewController(animated: true)
    }

    func didTapSignUpButton(_ signUpView: SignUpView, inputTextFieldValues: [String: String], profileImage: Data) {
        AuthenticationAPI.shared.registerUser(with: inputTextFieldValues, profileImage: profileImage) { error, ref in
            if let error = error {
                print("Error Authenticate user -> \(error.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                let controller = MainTabController()
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }

}

//MARK: - UIImagePickerControllerDelegate
extension SignUpController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        viewModel?.plusPhotoImage = profileImage.withRenderingMode(.alwaysOriginal)
        dismiss(animated: true)
    }
}
