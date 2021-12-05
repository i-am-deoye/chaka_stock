//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


protocol ILocalQuery {
    associatedtype T
    
    func fetch(by query: Query)  -> [T]
    func delete(by query: Query)
}
