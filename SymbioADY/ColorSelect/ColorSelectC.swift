//
//  ColorSelectC.swift
//  SymbioADY
//
//  Created by ady on 2023/8/12.
//

import UIKit
import Colorful

typealias ColorSelectBlock = (UIColor) -> Void

class ColorSelectC: NavC {

    var colorSelectBlock: ColorSelectBlock?
    lazy var colorPicker: ColorPicker = {
        let colorPicker = ColorPicker()
        colorPicker.addTarget(self, action: #selector(colorAction), for:.valueChanged)
        colorPicker.set(color: .white, colorSpace: .sRGB)
        return colorPicker
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.barTitle = String.ady.colorSel

        self.view.addSubview(self.colorPicker)
        self.colorPicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(screenWidth)
        }
    }
    @objc func colorAction(){
        self.colorSelectBlock?(self.colorPicker.color)
        debugPrint(self.colorPicker.color.hex())
    }

}
