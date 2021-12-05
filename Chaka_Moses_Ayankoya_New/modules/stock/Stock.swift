//
//  Stock.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import Foundation
import RealmSwift


class Stock : Entity, Decodable {
    @objc dynamic var type: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var displaySymbol: String = ""
    @objc dynamic var currency: String = ""
    
    override public init() {
        super.init()
    }
    
    public override static func primaryKey() -> String? {
            return "id"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: StockKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        self.displaySymbol = try container.decodeIfPresent(String.self, forKey: .displaySymbol) ?? ""
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        self.id = symbol.hashValue
    }
}


fileprivate extension Stock {
    enum StockKeys : String, CodingKey {
        case type
        case symbol
        case displaySymbol
        case currency
    }
}


protocol IPrimitiveEntity : Persistable {
    associatedtype T
    var value : T { get set }
}


public class TimeStamp : Entity, IPrimitiveEntity {
    typealias T = Double
    
    @objc dynamic var value: Double = 0
    
    override public init() {
        super.init()
    }
    
    init(_ value: T) {
        super.init()
        self.value = value
        self.id = Int(value)
    }
    
    public override static func primaryKey() -> String? {
            return "id"
    }
}

public class OpenPrice : Entity, IPrimitiveEntity {
    typealias T = Double
    
    @objc dynamic var value: Double = 0
    
    override public init() {
        super.init()
    }
    
    init(_ value: T) {
        super.init()
        self.value = value
        self.id = Int(value)
    }
    
    public override static func primaryKey() -> String? {
            return "id"
    }
}


class StockDetails : Entity, Decodable {
    @objc dynamic var symbol: String = ""
    let timestamps = List<TimeStamp>()
    let openprices = List<OpenPrice>()
    
    override public init() {
        super.init()
    }
    
    public override static func primaryKey() -> String? {
            return "symbol"
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: StockDetailsKeys.self)
        let timestamps  = try container.decodeIfPresent([Double].self, forKey: .t) ?? []
        let openprices  = try container.decodeIfPresent([Double].self, forKey: .o) ?? []
        self.symbol = ""
        
        self.timestamps.append(objectsIn: timestamps.compactMap({ TimeStamp.init($0) }))
        self.openprices.append(objectsIn: openprices.compactMap({ OpenPrice.init($0) }))
        
    }
}


fileprivate extension StockDetails {
    enum StockDetailsKeys : String, CodingKey {
        case o
        case t
    }
}
