//
//  NavigationC.swift
//  SymbioADY
//
//  Created by ady on 2023/8/12.
//

import UIKit
import FDFullscreenPopGesture

class NavigationC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
