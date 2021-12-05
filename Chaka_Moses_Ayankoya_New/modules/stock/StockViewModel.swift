//
//  StockViewModel.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import Foundation

struct ChartItem {
    let price: Double
    let time: Double
}

protocol IStockViewModel {
    func getStocks(_ state: @escaping ((ViewModelState<[Stock]>) -> Void) )
    func getStockDetails(by symbol: String, state: @escaping ((ViewModelState<[ChartItem]>) -> Void))
}



final class StockViewModel: IStockViewModel {
    
    fileprivate let usecase : IStockUsecase
    
    init(_ usecase: IStockUsecase) {
        self.usecase = usecase
    }
    
    
    func getStocks(_ state: @escaping ((ViewModelState<[Stock]>) -> Void)) {
        state(ViewModelState.loading)
        self.usecase.getStocks { stocks in
            state(ViewModelState.result(payload: stocks))
        } error: { message in
            state(ViewModelState.failure(error: message))
        }

    }
    
    func getStockDetails(by symbol: String, state: @escaping ((ViewModelState<[ChartItem]>) -> Void)) {
        state(ViewModelState.loading)
        self.usecase.getStockDetails(symbol) { details in
            let chart =  (0..<details.timestamps.count).compactMap({ ChartItem.init(price:details.openprices[$0].value, time: details.timestamps[$0].value.toDay.toDouble ) })
            state(ViewModelState.result(payload: chart))
        } error: { message in
            state(ViewModelState.failure(error: message))
        }
    }
}
