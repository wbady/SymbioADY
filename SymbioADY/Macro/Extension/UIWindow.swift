//
//  UIWindow+Extension.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//

import UIKit

extension UIWindow {
    var topVC: UIViewController? {
        var resultVC: UIViewController?
        resultVC = _topVC(rootViewController)
        while resultVC?.presentedViewController != nil {
            resultVC = _topVC(resultVC?.presentedViewController)
        }
        return resultVC
    }
    
    private func _topVC(_ vc: UIViewController?) -> UIViewController? {
        if vc is UINavigationController {
            return _topVC((vc as? UINavigationController)?.topViewController)
        } else if vc is UITabBarController {
            return _topVC((vc as? UITabBarController)?.selectedViewController)
        } else {
            return vc
        }
    }
}
