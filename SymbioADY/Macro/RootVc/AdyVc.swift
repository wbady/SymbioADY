//
//  AdyVc.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftyJSON
import PromiseKit
import IQKeyboardManagerSwift

class AdyVc: UIViewController {
    
    let disposeBag = DisposeBag()
    
    /// 不支持屏幕转动
    override var shouldAutorotate: Bool {
        return false
    }
    
    /// 只支持竖屏模式
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        self.view.endEditing(true)
    }

    private func setup() {
        view.backgroundColor = UIColor.ady.background
        // 隐藏导航栏
        fd_prefersNavigationBarHidden = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapPressed(_:)))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc func tapPressed(_ recognizer:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    deinit {
        print("\n-------\(self)被释放!\n")
    }
}





