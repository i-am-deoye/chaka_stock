//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//


import Foundation
import RealmSwift


public final class RealmDriver : IDataBaseDriver {
    static let instance = RealmDriver()
    
    private var realm : Realm!
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            Logger.log(.e, messages: error.localizedDescription)
        }
        
        NotificationHelper.observe(self, selector: #selector(shouldLogoutNotification), name: .ShouldLogout)
    }
    
    public func save<T>(_ entity: T) {
        do {

            try realm.write {
                realm.add(entity as! Object, update: .modified)
                //NotificationHelper.post(.RealmDidSavedData, object: self, userInfo: nil)
            }
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
    
    public func save<T>(_ entities: [T]) {
        do {

            try realm.write {
                realm.add(entities as! [Object], update: .modified)
            }
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
    
    public func update<T>(_ handle: @escaping (() -> T)) {
        do {
            realm.beginWrite()
            _ = handle()
            try realm.commitWrite()
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
    
    public func delete<T>(_ entity: T) {
        do {
            try realm.write {
                realm.delete(entity as! Object)
            }
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
    
    public func delete<T>(_ entities: [T]) {
        entities.forEach({ self.delete($0) })
    }
    
    public func deleteAll<T>(_ type: T.Type) {
        guard let _type = type as? Object.Type else { return }
        
        do {
            try realm.write {
                let objects = fetch(_type)
                realm.delete(objects)
            }
        } catch { Logger.log(.e, messages: error.localizedDescription) }
        
        
    }
    
    public func fetch<T>(_ type: T.Type) -> [T] {
        let result = realm.objects(type as! Object.Type)
        return computeToList(result: result) as! [T]
    }
    
    public func filter<T>(_ type: T.Type, query: String) -> [T] {
        let result = realm.objects(type as! Object.Type).filter(query)
        return computeToList(result: result) as! [T]
    }
    
    fileprivate func computeToList<T>(result: Results<T>) -> [T] {
        var list: [T] = []
        
        for item in result {
            list.append(item)
        }
        
        return list
    }
}


fileprivate extension RealmDriver {
    
    @objc func shouldLogoutNotification(_ notification: Notification) {
        do {
            try realm.write {
                realm?.deleteAll()
            }
        } catch { Logger.log(.e, messages: error.localizedDescription) }
    }
}

