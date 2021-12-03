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

    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else { fatalError("Cannot convert display label text to Double") }
            return number
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        if let calcMethod = sender.currentTitle {
            calculator.setNumber(displayValue)
            guard let calculatorResult = calculator.calcualte(symbol: calcMethod) else { fatalError("Result of Calculation is nil") }
            displayLabel.text = String(calculatorResult)
        }
    }

    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." && displayLabel.text!.contains(".") { return }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }

}

