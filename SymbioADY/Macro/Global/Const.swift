//
//  Const.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//
import UIKit

/// 屏幕尺寸
let screenBounds = UIScreen.main.bounds
/// 屏幕宽度
let screenWidth = screenBounds.width
/// 屏幕高度
let screenHeight = screenBounds.height
/// 状态栏高度
let statusBarHeight = UIApplication.shared.statusBarFrame.height
/// 导航栏高度
let navBarHeight = statusBarHeight + 44
/// 是否齐刘海
let isIphoneXSerial: Bool = {
    var isIphoneX = false
    if #available(iOS 11, *) {
        if let keyWindow = UIApplication.shared.keyWindow {
            isIphoneX = keyWindow.safeAreaInsets.bottom > 0
        }
    }
    return isIphoneX
}()

/// 顶部安全区域
let topSafeArea: CGFloat = isIphoneXSerial ? 49 : 20
/// 底部安全区域
let bottomSafeArea: CGFloat = isIphoneXSerial ? 83 : 49
