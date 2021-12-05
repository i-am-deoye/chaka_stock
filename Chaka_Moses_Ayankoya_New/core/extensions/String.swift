//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


extension String {
    var isNotEmpty : Bool {
        return !self.replacingOccurrences(of: " ", with: "").isEmpty
    }
    
    var toInt: Int {
        return Int.init(self) ?? 0
    }
}
