//
//  ViewController.swift
//  ScrollView
//
//  Created by Heang Ly on 9/19/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: view.frame.size.height - 20))
        scrollView.backgroundColor = .green
        view.addSubview(scrollView)
        
        let topBtn = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        topBtn.backgroundColor = .blue
        scrollView.addSubview(topBtn)
        
        let midBtn = UIButton(frame: CGRect(x: 20, y: 2000, width: 100, height: 100))
        midBtn.backgroundColor = .orange
        scrollView.addSubview(midBtn)
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2200)
    
    }


}

