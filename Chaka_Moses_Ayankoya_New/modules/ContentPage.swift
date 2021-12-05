//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 30/11/2021.
//

import UIKit



class ContentPage<ContentView: UIView> : UIViewController {
    var contentView: ContentView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    func bind() {}
    
    func show(error message: String) {
        showSnackbar(message: message)
    }
    
    func startLoader() {
        showSpinner()
    }
    
    func stopLoader() {
        hideSpinner()
    }
}

fileprivate extension ContentPage {
    
    func hideSpinner(_ spinner: LoaderView? = nil) {
        if let value = self.view.subviews.filter({ $0.tag == LoaderView.tag }).first {
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .beginFromCurrentState) {
                value.alpha = 0
            } completion: { (_ ) in
                value.removeFromSuperview()
            }
        }
    }
    
    
    
    
    @discardableResult
    func showSpinner() -> LoaderView {
        hideSpinner()
        let spinner = LoaderView()
        view.addSubview(spinner)
        spinner.frame = view.frame
        return spinner
    }
    
    func showSnackbar(message: String, dismissHandler: (() -> Void)? = nil, fromTop : Bool = false) {
        let extractedExpr = SnackBar(fromTop: fromTop)
        let snackbar = extractedExpr
        snackbar.dismissHandler = dismissHandler
        snackbar.message.text = message
        snackbar.bar.backgroundColor = UIColor.orange
        self.view.addSubview(snackbar)
        snackbar.frame = self.view.frame
        snackbar.show()
    }
}


fileprivate extension ContentPage {
    func setup() {
         contentView = ContentView.init()
         contentView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(contentView)
         contentView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
         contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
         contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         
     }
}
