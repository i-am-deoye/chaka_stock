//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation



enum StockBaseUrl : String {
    case staged = "https://finnhub.io/"
    case live = ""
    
    static func getUrl(_ env: Environment) -> String {
        switch env {
        case .staged : return StockBaseUrl.staged.rawValue
        case .live : return StockBaseUrl.live.rawValue
        }
    }
}
