//
//  UITextFieldCustomClass.swift
//
//

import UIKit

class UITextFieldCustomClass: UITextFieldFontSize {
    
    @IBInspectable var placeholderColor: UIColor = UIColor.black {
        didSet {
            if let placeholder = self.placeholder {
                let attributes = [NSAttributedString.Key.foregroundColor: placeholderColor]
                attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            }
        }
    }
    
    
    
    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
}

