//
//  LoginViewModel.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/20/21.
//

import UIKit

struct LoginViewModel {
    private let loginView = LoginView()

    let plusPhotoImage: UIImage? {
        didSet {
            guard let plusPhotoImage = plusPhotoImage else { return }
            
        }
    }

    init(plusPhotoImage: UIImage? = nil) {
        self.plusPhotoImage = plusPhotoImage
    }
}
