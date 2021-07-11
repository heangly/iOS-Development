//
//  ViewController.swift
//  BullsEye
//
//  Created by Heang Ly on 7/1/21.
//

import UIKit

class ViewController: UIViewController {
    let maxPoint = 100
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0


    @IBOutlet var uiSlider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        uiSlider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        uiSlider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(
            top:0,
            left: 14,
            bottom: 0,
            right:14
        )
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        uiSlider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        uiSlider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func showAlert() {
        let title: String
        let difference = abs(currentValue - targetValue)
        let point = maxPoint - difference
        
        if difference == 0 {
            title = "Perfect!"
        }else if difference < 5 {
            title = "You almost had it"
        }else if difference  < 10 {
            title = "Pretty good!"
        }else{
            title = "Not even close.."
        }
        
        let message = "You hit:\(currentValue) \nTarget:\(targetValue) \nYour scored \(point) points"
       
        score += point

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            self.startNewRound()
        }
        
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOverPressed(){
        startNewGame()
    }

    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        uiSlider.value = Float(currentValue)

        updateLabels()
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }

}

