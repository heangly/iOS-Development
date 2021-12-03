//
//  Extension.swift
//  todo-cloudkit
//
//  Created by Heang Ly on 10/12/21.
//

import Foundation

extension Date {
    func convertToMonthYearDayFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        
        return dateFormatter.string(from: self)
    }
}
