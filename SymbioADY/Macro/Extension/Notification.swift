//
//  Notification.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//

import Foundation

extension Notification.Name {
    /// 更新Window
    static var updateWindow = Notification.Name("updateWindow")
 
}

extension NotificationCenter {
    func addObserver(_ forName: NSNotification.Name?, using block: @escaping (Notification) -> Void) {
        addObserver(forName: forName, object: nil, queue: nil, using: block)
    }
}
