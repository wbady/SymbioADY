//
//  String+Extension.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

extension String: AdyCompatible {}

extension Ady where Base == String {
    
    static let SignUpList1 = "Avatar"
    static let SignUpList2 = "First Name"
    static let SignUpList3 = "Last Name"
    static let SignUpList4 = "Phone Number"
    static let SignUpList5 = "Email"
    static let SignUpList6 = "Custom Avatar Color"
    static let SignUpInput = "Input"
    static let SignUpSel   = "Please select"
    static let SignUpBtn   = "Sign Up"
    static let registration   = "Registration"

    /**完成*/
    static let  done = "完成"
    /**确定*/
    static let g_sure = "确定"
    /**取消*/
    static let g_cannel = "取消"
    /**登录*/
    static let loginUp = "登录"
    /**注册*/
    static let signUp = "注册"
    /**注册*/
    static let isSignUp = "确定注册当前信息吗？"
    /**选择颜色*/
    static let colorSel = "选择颜色"
}
