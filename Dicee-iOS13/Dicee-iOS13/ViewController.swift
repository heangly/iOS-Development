//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    let dices = [#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func rollButton(_ sender: UIButton) {
        diceImageView1.image = getRandomDice()
        diceImageView2.image = getRandomDice()
    }
    
    func getRandomDice()-> UIImage {
        let idx =  Int.random(in: 0..<dices.count)
        print(idx)
        return dices[idx]
    }


}

