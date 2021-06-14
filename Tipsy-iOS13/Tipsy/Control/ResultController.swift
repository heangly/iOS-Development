//
//  ResultController.swift
//  Tipsy
//
//  Created by Heang Ly on 6/13/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    var tipToGiveForEachPerson: Float?
    var splitNumber: Int?
    var splitPercent: Float?
 

    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var resultDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalPerPersonLabel.text = String(format: "%.2f USD", tipToGiveForEachPerson!)
        resultDetails.text = "Split between \(splitNumber!) , with \(Int(splitPercent! * 100))% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
