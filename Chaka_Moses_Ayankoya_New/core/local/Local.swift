//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


typealias ILocal = ILocalCRUD & ILocalQuery

open class Local <E> : ILocal where E : Persistable {
    
    public typealias T = E
    private var entityClass: E.Type!
    private var db : IDataBaseDriver!
    
    private init() {}
    
    public init(entityClass: E.Type, db: IDataBaseDriver?) {
        
        guard let db = db else { Logger.log(.s, messages: "Local cant be nil"); return }
        
        self.entityClass = entityClass
        self.db = db
    }
    
    private func isPersistable(_ entity: Any) -> Bool {
        guard entity is Persistable else { return false }
        return true
    }
    
    private func throwIfPersistableError(_ entity: T) {
        assert(isPersistable(entity), "Persistable must be implemented to your Entity Class")
    }
    
    public func save(_ entity: E)  {
        throwIfPersistableError(entity)
        db.save(entity)
    }
    
    public func save(_ entities: [E]) {
        db.save(entities)
    }
    
    public func fetch(by id: String) -> [E] {
        let query = Query().equal(key: "id", value: Int(id) ?? 0)
        return fetch(by: query)
    }
    
    public func fetch() -> [E] {
        let result = db.fetch(entityClass)
        return result
    }
    
    public func update(_ handle: @escaping (() -> T)) {
            db.update(handle)
    }
    
    public func delete(_ entity: E) {
        db.delete(entity)
    }
    
    public func fetch(by query: Query) -> [E] {
        var result = db.fetch(entityClass)
        result = db.filter(E.self, query: query.toString())
        return result
    }
    
    public func delete(by query: Query) {
        let result = db.fetch(entityClass)
        db.delete(result)
    }
    
    func deleteAll() {
        db.deleteAll(entityClass)
    }
    
}
