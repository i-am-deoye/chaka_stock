//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


public protocol IDataBaseDriver {
    func save<T>(_ entity: T)
    func save<T>(_ entities: [T])
    func update<T>(_ handle: @escaping (() -> T ) )
    func delete<T>(_ entity: T)
    func delete<T>(_ entities: [T])
    func deleteAll<T>(_ type: T.Type)
    func fetch<T>(_ type: T.Type) -> [T]
    func filter<T>(_ type: T.Type, query: String) -> [T]
}
