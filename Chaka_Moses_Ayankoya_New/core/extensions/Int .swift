//
//  Int .swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 04/12/2021.
//

import Foundation

extension Int {
    var toString: String {
        return "\(self)"
    }
    
    var toDouble: Double {
        return Double(self)
    }
}


extension Double {
    var toDay: Int {
        return Date.get(date: Date.init(timeIntervalSince1970: self)).day
    }
}
