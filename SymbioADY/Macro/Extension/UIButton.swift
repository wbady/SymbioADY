//
//  UIButton+Extension.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        setBackgroundImage(color.toImage(), for: forState)
    }
}
