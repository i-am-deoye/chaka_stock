//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    
    mutating func appendBool(_ bool : Bool){
        let boolData = try! JSONEncoder().encode(bool)
        self.append(boolData)
    }
    
    mutating func appendInt(_ int : Int){
        let intData = try! JSONEncoder().encode(int)
        self.append(intData)
    }
}
