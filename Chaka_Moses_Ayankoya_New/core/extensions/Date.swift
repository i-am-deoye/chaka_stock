//
//  Date.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 05/12/2021.
//

import Foundation

typealias YEAR_MONTH_DAY = (year: Int, month: Int, day: Int)

extension Date {
    
    static func get(date: Date) -> YEAR_MONTH_DAY {
        let formatter = DateFormatter()
        formatter.locale = Locale.current

        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        
        return (year.toInt, month.toInt, day.toInt)
    }
}
