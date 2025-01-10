import UIKit

extension UITextField {
    func setPadding(left: CGFloat, right: CGFloat) {
        if left > 0 {
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
        }
        if right > 0 {
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
        }
    }
    
    func setLeftPadding(left: CGFloat) {
        if left > 0 {
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
        }
    }
    
    func setRightPadding(right: CGFloat) {
        if right > 0 {
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
        }
    }
}
