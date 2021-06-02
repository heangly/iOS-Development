//
//  ViewController.swift
//  magic8ball
//
//  Created by Heang Ly on 6/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ballImage: UIImageView!
    let ballImages = [#imageLiteral(resourceName: "ball2"),#imageLiteral(resourceName: "ball1"),#imageLiteral(resourceName: "ball3"),#imageLiteral(resourceName: "ball1"),#imageLiteral(resourceName: "ball3")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func askButton(_ sender: UIButton) {
        ballImage.image = ballImages[Int.random(in: 0..<ballImages.count)]
    }


}

