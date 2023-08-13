//
//  NavC.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit

class NavC: AdyVc {
    
    /// 导航栏风格
    enum BarStyle {
        case clear
        case black
        case lightBlack
        case blackWithClearBackground
    }
    
    let navBar = NavigationBar()
    
    /// 内容视图（除去导航栏的全部视图）
    let contentView = UIView().then {
        $0.backgroundColor = UIColor.ady.background2
    }
    
    var barTitle = "" {
        didSet {
            navBar.titleLabel.text = barTitle
        }
    }
    
    /// 导航栏风格属性，default .black
    var barStyle: BarStyle = .black {
        didSet {
            setupBarStyle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(navBar)
        view.addSubview(contentView)
        
        navBar.snp.makeConstraints { (maker) in
            maker.left.top.right.equalToSuperview()
            maker.height.equalTo(navBarHeight)
        }
        
        contentView.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalToSuperview()
            maker.top.equalTo(navBar.snp.bottom)
        }
        
        navBar.onBackClosure = { [weak self] in
            guard let self = self else { return }
            self.back()
        }
        
        navBar.onRightClosure = { [weak self] in
            guard let self = self else { return }
            self.onRight()
        }
    }
    
    private func setupBarStyle() {
        switch barStyle {
        case .black:
            navBar.backgroundColor = UIColor.white
            navBar.backButton.setImage(UIImage.ady.return_white, for: .normal)
            navBar.titleLabel.textColor = UIColor.black
            navBar.rightButton.setTitleColor(.black, for: .normal)
            contentView.snp.remakeConstraints { (maker) in
                maker.top.equalTo(navBar.snp.bottom)
                maker.left.bottom.right.equalToSuperview()
            }
        case .clear:
            navBar.backgroundColor = UIColor.white.withAlphaComponent(0)
            navBar.titleLabel.textColor = UIColor.white
            navBar.backButton.setImage(UIImage.ady.return_white, for: .normal)
            navBar.rightButton.setTitleColor(.white, for: .normal)
            view.bringSubviewToFront(navBar)
            contentView.snp.remakeConstraints { (maker) in
                maker.edges.equalToSuperview()
            }
        case .lightBlack:
            navBar.backgroundColor = UIColor.black
            navBar.titleLabel.textColor = UIColor.white
            navBar.backButton.setImage(UIImage.ady.return_white, for: .normal)
            navBar.rightButton.setTitleColor(.white, for: .normal)
            view.bringSubviewToFront(navBar)
            contentView.snp.remakeConstraints { (maker) in
                maker.top.equalTo(navBar.snp.bottom)
                maker.left.bottom.right.equalToSuperview()
            }
        case .blackWithClearBackground:
            navBar.backgroundColor = UIColor.white
            navBar.backButton.setImage(UIImage.ady.return_white, for: .normal)
            navBar.titleLabel.textColor = UIColor.black
            navBar.rightButton.setTitleColor(.black, for: .normal)
        }
    }
    
    func back() {
        if let navc = navigationController {
            if let firstVc = navc.viewControllers.first, firstVc == self {
                dismiss()
            } else {
                pop()
            }
        } else {
            dismiss()
        }
    }
    
    /// 子类实现
    /// 点击导航栏右侧Item
    func onRight() {
        
    }
}


