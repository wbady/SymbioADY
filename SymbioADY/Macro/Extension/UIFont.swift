//
//  UIFont+Extension.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit

extension UIFont: AdyCompatible {}

extension Ady where Base == UIFont {
    
    /**标题使用*/
    static let title                 =    UIFont(.Ping_R, 15)
    /**textfield使用*/
    static let field                 =    UIFont(.Ping_R, 14)
    /**按钮使用*/
    static let btn                 =    UIFont(.Ping_R, 18)

}

extension UIFont {
    enum Name: String {
        /**苹方-简 常规体*/
        case Ping_R = "PingFangSC-Regular"
        /**苹方-简 中体*/
        case Ping_M = "PingFangSC-Medium"
        /**苹方-简 中粗体*/
        case Ping_S = "PingFangSC-Semibold"
    }
    
    convenience init(_ name: UIFont.Name, _ size: CGFloat) {
        self.init(name: name.rawValue, size: size)!
    }
}
