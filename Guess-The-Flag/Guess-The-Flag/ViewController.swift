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
    var correctAnswer = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        countries.append(contentsOf: ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"])
        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        title = countries[correctAnswer].uppercased()

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor

        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor

        button3.setImage(UIImage(named: countries[2]), for: .normal)
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor

    }

    func getRandomImageName() -> String {
        let idx = Int.random(in: 0..<countries.count)
        return countries[idx]
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score = score > 0 ? score - 1 : 0
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
}

