//
//  Global.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//

import UIKit
import Foundation
import Moya
import RxSwift
import RxCocoa
import Then


var global = Global()

enum LoginEnum:Int {
    case login_Out = 1
    case login_Up
    
}



enum InputStatus:Int{
    case statusNormal = 0//正常状态无输入
    case statusText//文本输入状态
    case statusMoreText//更多功能状态-文本
    case statusMoreTalk//更多功能状态-语音
    case statusTalk//语音输入状态
}

class Global {

    //用户管理
//    var userManager = UserManager.shared

    //键盘输入框
    var registrationTextView: RegistrationTextV?

    //键盘高度
    var keyboardHeight:CGFloat = 0

    
    func initialize() {

    }

    func getTopView() -> UIView? {
        return getTopVc()?.view
    }

    func getWindow()-> UIWindow?{
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        return keyWindow
    }

    func getTopVc() -> UIViewController? {
        return getWindow()?.topVC
    }

    func get_Button(_ view : UIView,_ title : String) -> UIButton{
        let btn = UIButton(type: .custom).then{
            $0.setBackgroundColor(UIColor.ady.btnNorColor, forState: .normal)
            $0.setBackgroundColor(UIColor.ady.btnSelColor, forState: .highlighted)
            $0.titleLabel?.textColor = .white
            $0.layer.cornerRadius = 12
            $0.layer.masksToBounds = true
            $0.setTitle(title, for: .normal)
        }
        view.addSubview(btn)
        return btn
    }
}


