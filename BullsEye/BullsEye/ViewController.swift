//
//  ViewController.swift
//  BullsEye
//
//  Created by Heang Ly on 7/1/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var uiSlider: UISlider!
    var currentValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(uiSlider.value)
    }
    
    @IBAction func showAlert(){
        let message = "The value of the slider is: \(currentValue)"
        let alert = UIAlertController(title: "Hello World", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue =  lroundf(slider.value)
    }

}

