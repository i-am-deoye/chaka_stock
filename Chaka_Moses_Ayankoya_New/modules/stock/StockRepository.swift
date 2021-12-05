//
//  StockRepository.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import Foundation



protocol StockDataSource : IDataSource {
    func getStocks(_ handler: @escaping ((RemoteResult<[Stock], String>) -> Void) )
    func getStockDetails(_ symbol: String, handler: @escaping ((RemoteResult<StockDetails, String>) -> Void) )
}


final class StockRepository : StockDataSource {
    static let instance = StockRepository()
    
    func getStocks(_ handler: @escaping ((RemoteResult<[Stock], String>) -> Void)) {
        StocksEndpoints.getStocks.connect(method: .get, handler: handler)
    }
    
    func getStockDetails(_ symbol: String, handler: @escaping ((RemoteResult<StockDetails, String>) -> Void)) {
        StocksEndpoints.getStocksDetails.connect(method: .get, pathValue: nil, pathQuery: "?symbol=\(symbol)&resolution=W&from=1606867164&to=16073855648&token=c6jagaqad3ieecon24vg", handler: handler)
    }
}
