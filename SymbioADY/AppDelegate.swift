//
//  AppDelegate.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit
import RxSwift
import SwiftyUserDefaults

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.launch(launchOptions)
        return true
    }
    func launch(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        _ = NotificationCenter.default.rx.notification(.updateWindow).subscribe { [weak self] (_) in
            self?.toWindow(launchOptions)
        }
        App.initialize()
        toWindow(launchOptions)
        
        
        global.initialize()
        
    }
    
    func toWindow(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        let isLogin = Defaults[\.isLogin]
        if isLogin == LoginEnum.login_Up.rawValue{
            self.window?.rootViewController = NavigationC(rootViewController: ViewController())
        }else{
            self.window?.rootViewController = NavigationC(rootViewController: RegistrationVc())
        }
        self.window?.makeKeyAndVisible()

    }


}

