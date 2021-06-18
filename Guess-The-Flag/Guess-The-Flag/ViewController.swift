//
//  ViewController.swift
//  Guess-The-Flag
//
//  Created by Heang Ly on 6/18/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        countries.append(contentsOf: ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"])
        askQuestion()
    }

    func askQuestion() {
        button1.setImage(UIImage(named: getRandomImageName()), for: .normal)
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        
        button2.setImage(UIImage(named: getRandomImageName()), for: .normal)
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        
        button3.setImage(UIImage(named: getRandomImageName()), for: .normal)
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
      
    }

    func getRandomImageName() -> String {
        let idx = Int.random(in: 0..<countries.count)
        return countries[idx]
    }

}

