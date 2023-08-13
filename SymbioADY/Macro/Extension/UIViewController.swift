//
//  UIViewController.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//

import PromiseKit
import UIKit

extension UIViewController {
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop(_ animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRoot(_ animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func present(_ viewController: UIViewController, _ animated: Bool = true) {
        present(viewController, animated: animated, completion: nil)
    }
    
    func dismiss(_ animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }
    
    @discardableResult
    func show_Alert(_ title : String) -> Promise<String>{
        return Promise(){(seal) in
            let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
            let cancel = UIAlertAction(title: String.ady.g_cannel, style: .default, handler: nil)
            let ok = UIAlertAction(title: String.ady.g_sure, style: .destructive) { (ac) in
                seal.fulfill("")
            }
            alert.addAction(cancel)
            alert.addAction(ok)
            present(alert)
        }
    
    }
}

extension UITableViewCell {
    static var identifier: String {
        return NSStringFromClass(self)
    }
}
