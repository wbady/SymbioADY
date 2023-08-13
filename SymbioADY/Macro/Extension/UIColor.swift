//
//  UIColor+Extension.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit

extension UIColor: AdyCompatible {}

extension Ady where Base == UIColor {
    /**背景颜色*/
    static let background = UIColor.white
    static let background2 = UIColor(r: 241, g: 241, b: 246, a: 1.0)
    static let background3 = UIColor(r: 243, g: 243, b: 243, a: 1.0)
    /**nav标题颜色*/
    static let navTitleColor = UIColor.white
    /**默认title颜色*/
    static let titleColor = UIColor(r: 96, g: 98, b: 102, a: 1.0)
    /**头像背景颜色*/
    static let avatarColor = UIColor(r: 218, g: 232, b: 252, a: 1.0)
    /**field颜色*/
    static let fieldColor = UIColor(r: 112, g: 155, b: 155, a: 1.0)
    /**按钮nor颜色*/
    static let btnNorColor = UIColor(r: 79, g: 111, b: 169)
    /**按钮sel颜色*/
    static let btnSelColor = UIColor(r: 41, g: 114, b: 191)
}

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1.0)
    }
    
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func hex(hashPrefix: Bool = true) -> String {
      var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
      getRed(&r, green: &g, blue: &b, alpha: &a)
      
      let prefix = hashPrefix ? "#" : ""
      
      return String(format: "\(prefix)%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}
