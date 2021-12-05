//
//  StocksEndpoints.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import Foundation


enum StocksEndpoints : String, IEndPoints {
    case getStocks = "api/v1/stock/symbol?exchange=US&token=c6jagaqad3ieecon24vg"
    case getStocksDetails = "api/v1/stock/candle"
    
    
    
    
    func getValue() -> String {
        return self.rawValue
    }
    
    func getEnvUrl() -> BaseEnvUrl {
        return .finn_hub
    }
    
    
}
