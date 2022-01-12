//
//  GradientViewClass.swift
//
//

import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(red: 255/255, green: 138/255, blue: 49/255, alpha: 1.0).cgColor, UIColor(red: 255/255, green: 138/255, blue: 49/255, alpha: 1.0).cgColor, UIColor(red: 234/255, green: 125/255, blue: 47/255, alpha: 1.0).cgColor, UIColor(red: 164/255, green: 88/255, blue: 57/255, alpha: 1.0).cgColor, UIColor(red: 95/255, green: 51/255, blue: 85/255, alpha: 1.0).cgColor, UIColor(red: 52/255, green: 31/255, blue: 106/255, alpha: 1.0).cgColor]
    }
}
