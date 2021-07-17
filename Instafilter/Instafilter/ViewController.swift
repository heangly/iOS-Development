//
//  ViewController.swift
//  Instafilter
//
//  Created by Heang Ly on 7/17/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var currentImage: UIImage!

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }

    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        currentImage = image
    }


    @IBAction func changeFilter(_ sender: Any) {

    }

    @IBAction func intensityChanged(_ sender: Any) {

    }



}

