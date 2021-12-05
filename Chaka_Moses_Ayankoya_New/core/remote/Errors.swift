//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


enum Errors : String, Error {
    case internalParsedDataError = "Something went wrong, we surely looking into this."
    case networkUnreachable = "Network not reachable"
    
   static func getType(_ message: String) -> Errors {
        if Errors.internalParsedDataError.rawValue == message { return .internalParsedDataError}
        
        return .internalParsedDataError
    }
}
