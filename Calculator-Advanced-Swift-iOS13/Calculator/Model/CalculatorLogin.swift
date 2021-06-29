//
//  CalculatorLogin.swift
//  Calculator
//
//  Created by Heang Ly on 6/29/21.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    private var intermediateCalculation: (n1: Double, calcMethod: String)?

    mutating func setNumber(_ number: Double) {
        self.number = number
    }

    mutating func calcualte(symbol: String) -> Double? {
        guard let number = number else { return nil }

        switch(symbol) {
        case "+/-":
            return number * -1
        case "AC":
            return 0
        case "%":
            return number / 100
        case "+":
            intermediateCalculation = (n1: number, calcMethod: symbol)
        case "=":
            return performTwoNumCalculation(number)
        default:
            intermediateCalculation = (n1: number, calcMethod: symbol)
        }
        
        return nil
    }

    private func performTwoNumCalculation(_ n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {

            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n1
            case "÷":
                return n1 / n2
            default:
                fatalError("Then operation passed in does not match any casesr")
            }
        }
        return nil
    }


}
