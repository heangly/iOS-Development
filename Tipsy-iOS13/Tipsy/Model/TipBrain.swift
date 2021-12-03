//
//  TipBrain.swift
//  Tipsy
//
//  Created by Heang Ly on 6/13/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

struct TipBrain {
    private var totalBill: Float?
    private var tipPercent: Float?
    private var splitNumber: Int?
    
    func getTotalBill() -> Float? {
        return totalBill
    }
    
    mutating func setTotalBill(amount: Float) {
        self.totalBill = amount
    }
    
    func getTipPercent() -> Float? {
        return self.tipPercent
    }
    
    mutating func setTipPercent(amount: Float) {
        self.tipPercent = amount
    }
    
    func getSplitNumber() -> Int? {
        return splitNumber
    }
    
    mutating func setSplitNumber(number: Int) {
        self.splitNumber = number
    }
    
    func calculateTip() -> Float? {
        if let totalBill = totalBill,
           let tipPercent = tipPercent,
           let splitNumber = splitNumber {
            let tipToGiveForEach = (totalBill * tipPercent) / Float(splitNumber)
            let tipSplitForEachPerson = totalBill / Float(splitNumber) + tipToGiveForEach
            return tipSplitForEachPerson
        }
       return nil
    }
}
