//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 30/11/2021.
//

import UIKit
import Swinject
import Charts


extension DetailStockPricePage {
    static func register( using container: Container) {
        container.register(DetailStockPricePage.self) { r in
            let controller = DetailStockPricePage()
            controller.viewmodel = StockViewModel.init(StockUsecase.init(StockRepository.instance))
           return controller
        }
    }
}


final class DetailStockPricePage : ContentPage<DetailStockPriceView>, Segueable {
    var anyData: Any?
    fileprivate var viewmodel: IStockViewModel!
    
    override func bind() {
        guard let stock = anyData as? Stock else { return }
        viewmodel.getStockDetails(by: stock.symbol, state: onStated)
    }
    
    private func onStated(_ state: ViewModelState<[ChartItem]>) {
       stopLoader()
        
        switch state {
        case .loading :
            startLoader()
        case .failure(error: let message):
            show(error: message)
        case .result(payload: let chart):
            contentView.setData(chart)
        }
    }
}







 final class DetailStockPriceView : UIView {
     var chartView: LineChartView!
     
     init() {
         super.init(frame: .zero)
         setup()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setup()
     }
     
     func setup() {
         chartView = LineChartView.init()
         chartView.translatesAutoresizingMaskIntoConstraints = false
         self.addSubview(chartView)
         chartView.fillSuperview()
         
         chartView.delegate = self
                 
         chartView.backgroundColor = .white
         chartView.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
         chartView.drawGridBackgroundEnabled = true
         
         chartView.drawBordersEnabled = true
         
         chartView.chartDescription.enabled = false
         
         chartView.pinchZoomEnabled = false
         chartView.dragEnabled = true
         chartView.setScaleEnabled(true)
         
         chartView.legend.enabled = false
         
         chartView.xAxis.enabled = false
         
         let leftAxis = chartView.leftAxis
         leftAxis.axisMaximum = 900
         leftAxis.axisMinimum = -250
         leftAxis.drawAxisLineEnabled = false
         
         chartView.rightAxis.enabled = false
     }
     
     func setData(_ chart: [ChartItem]) {
         
         let yVals1 = (0..<chart.count).map { (i) -> ChartDataEntry in
             let item = chart[i]
             let y = item.time
             Logger.log(.i, messages: "\(item.price)" + " \(y)")
             return ChartDataEntry(x: Double(i), y: y)
         }
         
         
             
         let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
         set1.axisDependency = .left
         set1.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
         set1.drawCirclesEnabled = false
         set1.lineWidth = 2
         set1.circleRadius = 3
         set1.fillAlpha = 1
         set1.drawFilledEnabled = true
         set1.fillColor = .white
         set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
         set1.drawCircleHoleEnabled = false
         set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
             return CGFloat(self.chartView.leftAxis.axisMinimum)
         }
         

         let data: LineChartData = [set1]
         data.setDrawValues(false)
         
         chartView.data = data
     }
}


extension DetailStockPriceView: ChartViewDelegate {
    
}
