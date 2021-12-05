//
//  SnackBar.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import UIKit

class SnackBar: UIView {
    
    var dismissHandler : (() -> Void)?
    var bar: UIView!
    var message: UILabel!
    let fromTop : Bool
    
    init(fromTop : Bool = false){
        self.fromTop = fromTop
        super.init(frame: .zero)
        setupView()
        show()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        bar = generateView()
        bar.backgroundColor = UIColor.green
        
        message = generateLabel(title: "Message", size: 13)
        message.textColor = .white
        message.numberOfLines = 0
        
        addSubviews(bar)
        
        bar.anchor(top: fromTop ?  topAnchor : bottomAnchor , leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                   padding: UIEdgeInsets(top: fromTop ? -70 : 0, left: 0, bottom: 0, right: 0))
        bar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        bar.addSubviews(message)
        message.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, delay: 5) {
            self.bar.transform = CGAffineTransform(translationX: 0, y: self.fromTop ? -70 : 70)
        } completion: { (_) in
            self.dismissHandler?()
            self.removeFromSuperview()
        }

    }
    
    
    func show() {
        UIView.animate(withDuration: 0.5) {
            self.bar.transform = CGAffineTransform(translationX: 0, y: 0)
            self.hide()
        }
    }
    
}
