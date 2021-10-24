//
//  Extensions.swift
//  StockAPI
//
//  Created by Heang Ly on 10/24/21.
//

import UIKit

extension UITextField {
    func addDoneButton(){
        let screenWidth = UIScreen.main.bounds.width
        let doneToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth , height: 50))
        doneToolBar.barStyle = .default
        let flexBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonDidTap))
        doneToolBar.items = [flexBarButtonItem, doneButtonItem]
        doneToolBar.sizeToFit()
        inputAccessoryView = doneToolBar
    }
    
    @objc private func doneButtonDidTap(){
        resignFirstResponder()
    }
}
