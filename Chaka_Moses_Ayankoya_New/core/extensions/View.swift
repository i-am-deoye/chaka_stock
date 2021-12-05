//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import UIKit
import WebKit
import SwiftUI

extension UIView {
    
    // Add SubViews
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
    
     func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // Generate Textfield
    func generateTextField(title: String, shouldAddPadding : Bool = true) -> UITextField {
        let tv = UITextField()
        tv.placeholder = title
        tv.translatesAutoresizingMaskIntoConstraints = false
        if shouldAddPadding{
            let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
            tv.leftView = paddingView
            tv.leftViewMode = .always
        }
        return tv
    }

    
    // Generate TextView
    func generateTextView(content: String, size: CGFloat) -> UITextView {
        let textView = UITextView()
        textView.text = content
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        return textView
    }
    
    //Generate Collectionview
    func generateCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }
    
    
    
    //Generate Collectionview
    func generateHorizontalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }
    
    // Generate Label
    func generateLabel(title: String, size: CGFloat) -> UILabel {
        let lb = UILabel()
        lb.text = title
        lb.font = UIFont(name: "Itim", size: size)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }
    
    
    func generateUnderlinedLabel(title: String, size: CGFloat) -> UILabel {
        let lb = UILabel()
        lb.text = ""
        lb.font = UIFont(name: "Itim", size: size)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: title, attributes: underlineAttribute)
        lb.attributedText = underlineAttributedString
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }
    
    // Generate Mullish Font Label
    func generateLabel2(title: String, size: CGFloat, fontName : String = "Mulish", color : UIColor) -> UILabel {
        let lb = UILabel()
        lb.text = title
        lb.textColor = color
        lb.font = UIFont(name: fontName, size: size)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }
    
    func convertHtmlToAttributedString(htmlString: String,
                                       font: UIFont? = UIFont(name: "Mulish", size: 20), color: UIColor?) -> NSMutableAttributedString{
        let data = Data(htmlString.utf8)
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                                          .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)  else {
            return NSMutableAttributedString(string: htmlString)
        }
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : color ?? UIColor.darkText,
                                                           .font : font ?? UIFont.systemFont(ofSize: 20)]
        
        let attributedQuote = NSMutableAttributedString(string: attributedString.mutableString as String)
        attributedQuote.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
        return attributedQuote
    }
    
    
    // Generate Label with Attributed text
    func generateLabelAttributed(title: String, size: CGFloat,
                                 font: UIFont? = UIFont(name: "Mulish", size: 20), color: UIColor?) -> UILabel {
        let lb = UILabel()
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : color ?? UIColor.darkText,
                                                           .font : font ?? UIFont.systemFont(ofSize: 20)]
        
        let attributedText = NSMutableAttributedString(string: title)
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: title.count))
     
        lb.attributedText = attributedText
    
        lb.font = UIFont.systemFont(ofSize: size)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }
    
    // Generate Button
    func generateButton (title: String, bgcolor: UIColor?, txtColor: UIColor?, font : UIFont =  UIFont(name: "Itim", size: 18) ?? UIFont.systemFont(ofSize: 18)) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: UIControl.State.normal)
        if(bgcolor != nil){btn.backgroundColor = bgcolor}
        btn.setTitleColor(txtColor, for: .normal)
        btn.titleLabel?.font = font
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    // Generate Image Button
    func generateImageButton (image: String) -> UIButton {
        let image = UIImage(named: image)
        let btn   = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    func generateNormalButton (title : String, color: UIColor = UIColor.white,
                               titleColor : UIColor,
                               font : UIFont = UIFont(name: "Muli-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)) -> UIButton {
        let btn   = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = font
        btn.backgroundColor = color
        btn.setTitleColor(titleColor, for: .normal)
        btn.makeCornerRadius(12)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    func generateImageButtonWithDiffRenderingMode (image: String, tintColor : UIColor = UIColor.green) -> UIButton {
        let image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        image?.withTintColor(tintColor)
        let btn   = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    func generateVerticalStackView(spacing : CGFloat = 10, alignment : UIStackView.Alignment = .fill,
                                   distribution : UIStackView.Distribution = .fill) -> UIStackView{
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func generateCardView(color : UIColor, cornerRadius : CGFloat = 12 ) -> UIView{
        let view = UIView()
        view.backgroundColor = color
        view.makeCornerRadius(cornerRadius)
        return view
    }
    
    // Generate Image
    func generateImage (src: String, contentMode : ContentMode = .scaleAspectFit) -> UIImageView {
        let iv = UIImageView(image: UIImage(named: src))
        iv.contentMode = contentMode
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }
    
    // Generate Image
    func generateImage (src: String) -> UIImageView {
        let iv = UIImageView(image: UIImage(named: src))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }
    
    func generateImage2 (src: String) -> UIImageView {
        let iv = UIImageView(image: UIImage(named: src))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }
    
    func generateImage2(image: UIImage) -> UIImageView{
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func addBorder(width : CGFloat = 1, color: UIColor){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    // Generate Image
    func generateImageViewWithDynamicRendering (src: String, contentMode : ContentMode = .scaleAspectFit) -> UIImageView {
        let iv = UIImageView(image: UIImage(named: src)?.withRenderingMode(.alwaysTemplate))
        iv.contentMode = contentMode
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }
    
    
    // Generate System Image
    func generateSystemImage (src: String) -> UIImageView {
        let iv = UIImageView(image: UIImage(systemName: src))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }
    
    func makeCircular(){
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
    }
    
    // Generate UIView
    func generateView () -> UIView {
        let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }
    
    // Generate ProgressView
    func generateProgressView () -> UIProgressView {
        let pv = UIProgressView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv;
    }
    
    // Generate Progressbar
    func generateProgressbar(progress: Float, trackColor: UIColor, tintColor: UIColor) -> UIProgressView {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.setProgress(progress, animated: true)
        pv.trackTintColor = trackColor
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.tintColor = tintColor
        return pv
    }
    
    // Generate ScrollView
    func generateScrollView () -> UIScrollView {
        let pv = UIScrollView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv;
    }
    
    func generateScaleView(origin : CGPoint, center : CGPoint) -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        frame = CGRect(origin: origin, size: CGSize(width: 1000, height: 1000))
        self.center = center
        layer.cornerRadius = 500
        layer.masksToBounds = true
        return view
    }
    
    
    func addGradientLayer(gradientColorOne : CGColor, gradientColorTwo : CGColor) -> CAGradientLayer {
      
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.frame
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)

        return gradientLayer
    }
    
    func generateSegmentedControl(items : [UIImage], cornerRadius : CGFloat = 38) -> UISegmentedControl{
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.layer.cornerRadius = cornerRadius
        segmentedControl.layer.masksToBounds = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .white
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.superview?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        return segmentedControl
    }
    
    
    // Generate WebView
    func generateWebView () -> WKWebView {
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv;
    }
    
    func estimateLabelSize(title : String, size : CGSize, attributes : [NSAttributedString.Key : Any]
                            = [NSAttributedString.Key.font: UIFont(name: "Mulish", size: 15) ?? UIFont()]) -> CGRect{
        let estimatedFrame = NSString(string: title).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return estimatedFrame
    }
    
    // Generate ActivitySpinner
    func generateActivityIndicator() -> UIActivityIndicatorView{
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
//        spinner.style = UIActivityIndicatorView.Style.medium
        spinner.startAnimating()
        return spinner
    }
    
    // Generate Blur Effect
    func generateBlurEffect () -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    // Border Radius
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
      let tap = UITapGestureRecognizer(target: target, action: action)
      tap.numberOfTapsRequired = tapNumber
      addGestureRecognizer(tap)
      isUserInteractionEnabled = true
    }
    
    func makeCornerRadius(_ radius : CGFloat = 4){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func generateAccuracyBezierPath() -> UIBezierPath{
        let circlePath = UIBezierPath()
        circlePath.move(to: CGPoint(x: 60.8, y: 3.8))
        circlePath.addCurve(to: CGPoint(x: 14.2, y: 102.7), controlPoint1: CGPoint(x: 11.6, y: 6.6), controlPoint2: CGPoint(x: -10.6, y: 62.5))
        circlePath.addCurve(to: CGPoint(x: 114.2, y: 98.7), controlPoint1: CGPoint(x: 35.2, y: 133.2), controlPoint2: CGPoint(x: 89.2, y: 131.9))
        circlePath.addCurve(to: CGPoint(x: 60.8, y: 3.8), controlPoint1: CGPoint(x: 139.9, y: 64.3), controlPoint2: CGPoint(x: 101.5, y: 1.4))
        circlePath.close()
        return circlePath
    }
    
    func generateSpeedBezierPath() -> UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 123.8, y: 66.5))
        path.addCurve(to: CGPoint(x: 30.9, y: 10.4), controlPoint1: CGPoint(x: 126.1, y: 17.6), controlPoint2: CGPoint(x: 73.1, y: -10.1))
        path.addCurve(to: CGPoint(x: 24.7, y: 109.5), controlPoint1: CGPoint(x: -1.3, y: 28), controlPoint2: CGPoint(x: -5.5, y: 81.5))
        path.addCurve(to: CGPoint(x: 123.8, y: 66.5), controlPoint1: CGPoint(x: 56.1, y: 138.4), controlPoint2: CGPoint(x: 122.1, y: 106.9))
        path.close()
        return path
    }
    
    func generateLineBezierPath() -> UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.1, y: 5.2))
        path.addCurve(to: CGPoint(x: 78.1, y: 2.5), controlPoint1: CGPoint(x: 0.4, y: 1.1), controlPoint2: CGPoint(x: 45, y: 1.5))
        path.addCurve(to: CGPoint(x: 134.9, y: 4.9), controlPoint1: CGPoint(x: 99.7, y: 3.2), controlPoint2: CGPoint(x: 135, y: 0.9))
        path.addCurve(to: CGPoint(x: 51.6, y: 7.7), controlPoint1: CGPoint(x: 134.8, y: 10.5), controlPoint2: CGPoint(x: 77.7, y: 8.3))
        path.addCurve(to: CGPoint(x: 0.1, y: 5.2), controlPoint1: CGPoint(x: 22.8, y: 7), controlPoint2: CGPoint(x: -0.4, y: 10.5))
        path.close()
        return path
    }
    
    func generateStatBezierPath2() -> UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 79.6, y: 4.5))
        path.addCurve(to: CGPoint(x: 18.6, y: 133.9), controlPoint1: CGPoint(x: 15.2, y: 8.2), controlPoint2: CGPoint(x: -13.9, y: 81.3))
        path.addCurve(to: CGPoint(x: 149.3, y: 128.6), controlPoint1: CGPoint(x: 46, y: 173.7), controlPoint2: CGPoint(x: 116.7, y: 172))
        path.addCurve(to: CGPoint(x: 79.6, y: 4.5), controlPoint1: CGPoint(x: 182.9, y: 83.6), controlPoint2: CGPoint(x: 132.7, y: 1.4))
        path.close()
        return path
    }
    
    func calculateViewSize (_ scrollView : UIScrollView) {
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }
    
    func roundTopCorners(_ raduis: CGFloat){
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
        layer.cornerRadius = raduis
    }
    
    func roundBottomCorners(_ raduis: CGFloat){
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.clipsToBounds = true
        layer.cornerRadius = raduis
    }
}


extension UICollectionViewCell {
    func gridCell() {
        self.layer.cornerRadius = 13
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset = CGSize(width: 0, height: 0.1)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UIViewController {
    func setupNavBar(title: String){
        navigationItem.title = title
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func setupNavBar2(title: String){
        navigationItem.title = title
        navigationController?.navigationBar.isTranslucent = false
    }
}

extension UIActivityIndicatorView {
    // Stop Indicator
    func stopIndicator(){
        self.stopAnimating()
        self.isHidden = true
    }
}

extension UITextField {
    
    func setBottomLine(borderColor: UIColor) {
        
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        let borderLine = UIView()
        let height = 0.75
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    


    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}






struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero, padding: UIEdgeInsets = .zero) {
      translatesAutoresizingMaskIntoConstraints = false
      if let superviewCenterXAnchor = superview?.centerXAnchor {
        centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: padding.left).isActive = true
      }
      if let superviewCenterYAnchor = superview?.centerYAnchor {
        centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
      }
      if size.width != 0 {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
      }
      if size.height != 0 {
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
      }
    }
    
    func reSize(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    
}
