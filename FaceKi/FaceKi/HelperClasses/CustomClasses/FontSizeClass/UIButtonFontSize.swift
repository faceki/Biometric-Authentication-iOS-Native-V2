//
//  UIButtonFontSize.swift
//
//

import UIKit

class UIButtonFontSize: UIButton {
    
    override func awakeFromNib() {
        changeSize()
        
    }
    
    fileprivate func changeSize() {
        let currentSize = self.titleLabel?.font.pointSize
        let fontDescriptor = self.titleLabel?.font.fontDescriptor
        if (UIScreen.main.bounds.height == 667){
            self.titleLabel?.font = UIFont(descriptor: fontDescriptor!, size: currentSize!-2)
        }
        else if (UIScreen.main.bounds.height == 568){
            self.titleLabel?.font = UIFont(descriptor: fontDescriptor!, size: currentSize!-3)
        }

    }
    
}
