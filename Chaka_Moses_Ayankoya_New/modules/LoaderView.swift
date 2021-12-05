//
//  LoaderView.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import UIKit


class LoaderView: UIView {
    static let tag = 10000100
    
    // MARK: - Properties
    var shape = CAShapeLayer()
    var container: UIView!
    var label: UILabel!
    var vector: UIImageView!
    var icon: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        setupView()
        icon.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.tag = LoaderView.tag
        container = generateView()
        container.backgroundColor = .white
        label = generateLabel(title: "Loading...", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .gray
        
        vector = generateImage(src: "spinner-vector")
        icon = generateImage(src: "success")
        
        var circleRadius: CGFloat {
            return container.bounds.size.height/2

         }
    
        
        addSubview(container)
        container.centerXAnchor.constraint(equalTo: centerXAnchor).isActive =  true
        container.centerYAnchor.constraint(equalTo: centerYAnchor).isActive =  true
        container.widthAnchor.constraint(equalToConstant: 300).isActive = true
        container.heightAnchor.constraint(equalToConstant: 300).isActive = true
        container.layer.cornerRadius = 20
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: circleRadius, y: circleRadius), radius: 30, startAngle: 0, endAngle: .pi * 1.8, clockwise: true)
        
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 5
        shape.strokeColor = UIColor.red.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 190
        shape.lineCap = .round
        shape.add(rotationAnimation(), forKey: "transform.rotation")
        container.layer.addSublayer(shape)
        
        shape.position = .init(x: 150, y: 150)
        
        container.addSubviews(vector, label, icon)
        
        
        
        label.anchor(top: nil, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 40, right: 20))
        icon.centerInSuperview()
        
        vector.anchor(top: nil, leading: nil, bottom: container.bottomAnchor, trailing: container.trailingAnchor)
        
    }

    
    func rotationAnimation()-> CAAnimation{
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1
        animation.repeatCount = MAXFLOAT

        return animation
    }
    
    func success(msg: String) {
        icon.isHidden = false
        label.text = msg
    }
   
}
