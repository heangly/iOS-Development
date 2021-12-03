//
//  LoginViewModel.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/20/21.
//

import UIKit

struct SignUpViewModel {
    private let signUpView: SignUpView
    
    var plusPhotoImage: UIImage? {
        didSet {
            guard let plusPhotoImage = plusPhotoImage else { return }
            signUpView.configurePlusPhotoImage(setImage: plusPhotoImage)
        }
    }

    init(view: SignUpView, plusPhotoImage: UIImage? = nil) {
        self.signUpView = view
        self.plusPhotoImage = plusPhotoImage
    }
}
