//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


protocol ILocalCRUD {
    associatedtype T
    
    func save(_ entity: T)
    func save(_ entities: [T])
    func fetch(by id: String)  -> [T]
    func fetch() -> [T]
    func update(_ handle: @escaping (() -> T ) )
    func delete(_ entity: T)
    func deleteAll()
}
