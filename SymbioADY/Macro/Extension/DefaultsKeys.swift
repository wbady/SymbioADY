//
//  DefaultsKeys.swift
//  SymbioADY
//
//  Created by ady on 2023/8/12.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    /**用户信息*/
    var user: DefaultsKey<String?> { .init("user", defaultValue: nil) }
    /**登录状态*/
    var isLogin: DefaultsKey<Int> { .init("isLoginOutOrUp", defaultValue: LoginEnum.login_Up.rawValue) }
}
