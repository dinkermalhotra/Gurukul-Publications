import UIKit

//MARK: String 
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

// MARK: - UICOLOR EXTENSION
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

// MARK: - UITAPGESTURE
extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
//MARK:- SEGMENT CONTORL 
extension UISegmentedControl{
    func removeBorder(){
      var bgcolor: CGColor
      var textColorNormal: UIColor
      var textColorSelected: UIColor
      
      if self.traitCollection.userInterfaceStyle == .dark {
        bgcolor = UIColor.black.cgColor
        textColorNormal = UIColor.gray
        textColorSelected = UIColor.white
      } else {
        bgcolor = UIColor.white.cgColor
        textColorNormal = UIColor.black
        textColorSelected = UIColor(red: 136, green: 0, blue: 155, alpha: 1.0)
      }
      
      let backgroundImage = UIImage.getColoredRectImageWith(color: bgcolor, andSize: self.bounds.size)
      self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
      self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
      self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
      
      let deviderImage = UIImage.getColoredRectImageWith(color: bgcolor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
      self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
      self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColorNormal], for: .normal)
      self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColorSelected], for: .selected)
      
    }
    
    func setupSegment() {
      DispatchQueue.main.async() {
      self.removeBorder()
      self.addUnderlineForSelectedSegment()
      }
    }
    
    func addUnderlineForSelectedSegment(){
      DispatchQueue.main.async() {
        self.removeUnderline()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(self.selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 4.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor =  UIColor(red: 136, green: 0, blue: 155, alpha: 1.0)
        underline.tag = 1
        self.addSubview(underline)
        
      }
    }
    
    func changeUnderlinePosition(){
      guard let underline = self.viewWithTag(1) else {return}
      let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
      underline.frame.origin.x = underlineFinalXPosition
    }
    
    func removeUnderline(){
      guard let underline = self.viewWithTag(1) else {return}
      underline.removeFromSuperview()
    }
  }

  extension UIImage{
    
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
      UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
      let graphicsContext = UIGraphicsGetCurrentContext()
      graphicsContext?.setFillColor(color)
      let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
      graphicsContext?.fill(rectangle)
      let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return rectangleImage!
    }

}


extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }
}
func alertModule(onVC viewController: UIViewController,title:String,msg:String){
       let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
       let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {(alert : UIAlertAction!) in
           alertController.dismiss(animated: true, completion: nil)
       })
       alertController.addAction(alertAction)
    viewController.present(alertController, animated: true, completion: nil)
   }

func showOKCancelAlertWithCompletion(onVC viewController: UIViewController, title: String, message: String, btnOkTitle: String, btnCancelTitle: String, onOk: @escaping ()->(), onCancel: @escaping ()->()) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnOkTitle, style:.default, handler: { (action:UIAlertAction) in
            onOk()
        }))
        alert.addAction(UIAlertAction(title: btnCancelTitle, style:.default, handler: { (action:UIAlertAction) in
            onCancel()
        }))
        alert.view.tintColor = UIColor.black
        alert.view.setNeedsLayout()
        viewController.present(alert, animated: true, completion: nil)
    }
}
