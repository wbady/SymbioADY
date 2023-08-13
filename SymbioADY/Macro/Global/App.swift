//
//  App.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import IQKeyboardManagerSwift

struct App {
    static func initialize() {
        initialize_sdk()
        initialze_keyboard()
    }
    
    private static func initialze_keyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = String.ady.done
    }
    
    private static func initialize_sdk() {
    }
    
}
