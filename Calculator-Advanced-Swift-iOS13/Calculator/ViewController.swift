//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        
        guard let number = Double(displayLabel.text!) else { fatalError("Cannot convert display label text to Double") }
        
    
        
        if let buttonValue = sender.currentTitle {
            switch(buttonValue){
            case "+/-":
                return
            default:
                return
            }
        }
    
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            }else{
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }

}

