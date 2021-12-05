//
//  IDataSource.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import Foundation

public protocol IDataSource {
}


extension IDataSource {
    
    
    
    func database<R:Persistable>(_ entity: R.Type) -> Local<R>? {
        return Local.init(entityClass: entity, db: RealmDriver.instance)
    }
    
    func update<R:Entity>(_ entity: R, handler: @escaping (() -> R)) {
        database(R.self)?.update(handler)
    }
    
    
    func save<R:Entity>(_ entity: R) {
        database(R.self)?.save(entity)
    }
    
    
    func save<R:Entity>(_ entities: [R]) {
        entities.forEach(save)
    }
    
}
