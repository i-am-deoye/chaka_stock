//
//  StockUsecase.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import Foundation


protocol IStockUsecase {
    func getStocks(_ result: @escaping (([Stock]) -> Void), error: @escaping ((String) -> Void) )
    func getStockDetails(_ symbol: String, result: @escaping ((StockDetails) -> Void), error: @escaping ((String) -> Void) )
}



final class StockUsecase : IStockUsecase {
    fileprivate let repository: StockDataSource
    fileprivate var errorHandler: ((String) -> Void)?
    fileprivate var stocksHandler: (([Stock]) -> Void)?
    fileprivate var stockDetailsHandler: ((StockDetails) -> Void)?
    fileprivate var symbol = ""
    
    init(_ repository: StockDataSource) {
        self.repository = repository
    }
    
    func getStocks(_ result: @escaping (([Stock]) -> Void),  error: @escaping ((String) -> Void)) {
        self.errorHandler = error
        self.stocksHandler = result
        
        if let stocks = repository.database(Stock.self)?.fetch(), !stocks.isEmpty { result(stocks) }
        else { self.repository.getStocks(onGotStocks) }
    }
    
    
    func getStockDetails(_ symbol: String, result: @escaping ((StockDetails) -> Void), error: @escaping ((String) -> Void)) {
        self.errorHandler = error
        self.stockDetailsHandler = result
        if let details = query(by: symbol) { result(details)  }
        else {  self.repository.getStockDetails(symbol, handler: onGotStockDetails) }
    }
    
    
    private func query(by symbol: String) -> StockDetails? {
        self.symbol = symbol
        let query = Query.init().equal(key: "symbol", value: symbol)
        return self.repository.database(StockDetails.self)?.fetch(by: query).first
    }
}


fileprivate extension StockUsecase {
    
    func onGotStocks(_ result: RemoteResult<[Stock], String>) {
        switch result {
        case .failure(error: let message):
            self.errorHandler?(message)
        case .success(payload: let stocks):
            BatchProcessing.process(stocks, batchSize: 500, pipe: { self.repository.save($0) }, done: {
                self.stocksHandler?(stocks)
            })
        }
    }
    
    func onGotStockDetails(_ result: RemoteResult<StockDetails, String>) {
        switch result {
        case .failure(error: let message):
            if let stocks = repository.database(Stock.self)?.fetch(), !stocks.isEmpty {
                stocksHandler?(stocks)
            }
            self.errorHandler?(message)
        case .success(payload: let details):
            details.symbol = self.symbol
            self.repository.save(details)
            self.stockDetailsHandler?(details)
        }
    }
}
