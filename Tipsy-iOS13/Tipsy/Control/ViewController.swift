//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tipBrain = TipBrain()
    
    @IBOutlet weak var totalBillInput: UITextField!
    
    @IBOutlet weak var zeroPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    
    @IBOutlet weak var splitAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tipBrain.setTipPercent(amount: 0.1)
        tipBrain.setSplitNumber(number: 2)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tipAmountPressed(_ sender: UIButton) {
        zeroPercentButton.isSelected = false
        tenPercentButton.isSelected = false
        twentyPercentButton.isSelected = false
        sender.isSelected = true
        
        let tipAmount = sender.currentTitle!.dropLast()
        let tipAmountInDecimal = Float(tipAmount)! / 100
        tipBrain.setTipPercent(amount: tipAmountInDecimal)
    }
    
    @IBAction func splitPressed(_ sender: UIStepper) {
        tipBrain.setSplitNumber(number: Int(sender.value))
        splitAmountLabel.text = String(Int(sender.value))
    }
    
    
    
    @IBAction func calculateTipPressed(_ sender: UIButton) {
        if let totalBill = totalBillInput.text, !totalBill.isEmpty {
            tipBrain.setTotalBill(amount: Float(totalBill)!)
        }
        
        if tipBrain.calculateTip() != nil{
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultController
            destinationVC.splitNumber = tipBrain.getSplitNumber()
            destinationVC.splitPercent = tipBrain.getTipPercent()
            destinationVC.tipToGiveForEachPerson = tipBrain.calculateTip()
        }
    }
    
    
    
    
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "goToResult" {
    //            let destinationVC = segue.destination as! ResultViewController
    //            destinationVC.bmiValue = calculatorBrain.getBMIValue()
    //            destinationVC.advice = calculatorBrain.getAdvice()
    //            destinationVC.color = calculatorBrain.getColor()
    //        }
    //    }
}

