//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 30/11/2021.
//

import UIKit
import Swinject


extension ListStockPricePage {
    static func register( using container: Container) {
        container.register(ListStockPricePage.self) { r in
            let controller = ListStockPricePage()
            controller.viewmodel = StockViewModel.init(StockUsecase.init(StockRepository.instance))
           return controller
        }
    }
}


final class ListStockPricePage : ContentPage<ListStockPriceView> {
    fileprivate var viewmodel: IStockViewModel!
    
    override func bind() {
        viewmodel.getStocks(onStated)
        contentView.onSelectedStockHandler = onSelected
    }
    
    private func onStated(_ state: ViewModelState<[Stock]>) {
       stopLoader()
        
        switch state {
        case .loading :
            startLoader()
        case .failure(error: let message):
            show(error: message)
        case .result(payload: let stocks):
            contentView.reload(with: stocks)
        }
    }
    
    private func onSelected(_ stock: Stock) {
        Segue.push(DetailStockPricePage.self, controller: self, anyData: stock, dismissableHandler: nil)
    }
}






final class ListStockPriceView : UIView {
    fileprivate static let cell_name = "UITableViewCell"
    
    fileprivate var stocksTableView: UITableView!
    fileprivate var stocks = [Stock]()
    fileprivate var onSelectedStockHandler: ((Stock) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func setup() {
        stocksTableView = UITableView()
        stocksTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stocksTableView)
        stocksTableView.fillSuperview()
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        stocksTableView.register(UITableViewCell.self, forCellReuseIdentifier: ListStockPriceView.cell_name)
    }
    
    func reload(with stocks: [Stock]) {
        self.stocks = stocks
        self.stocksTableView.reloadData()
    }
}


extension ListStockPriceView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListStockPriceView.cell_name, for: indexPath)
        let stock = self.stocks[indexPath.row]
        cell.textLabel?.text = stock.displaySymbol + " " + stock.type
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stock = self.stocks[indexPath.row]
        self.onSelectedStockHandler?(stock)
    }
}
