//
//  NavigationBar.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//

import UIKit

class NavigationBar: UIView {
    
    var onBackClosure: () -> () = {}
    var onRightClosure: () -> () = {}
    
    lazy var backButton = UIButton(type: .system).then {
        $0.setImage(UIImage.ady.return_white, for: .normal)
        $0.addTarget(self, action: #selector(onBack), for: .touchUpInside)
    }
    
    lazy var rightButton = UIButton(type: .system).then {
        $0.setTitleColor(UIColor.ady.titleColor, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.addTarget(self, action: #selector(onRight), for: .touchUpInside)
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 17, weight: .bold)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(rightButton)
        
        backButton.snp.makeConstraints { (maker) in
            maker.left.bottom.equalToSuperview().inset(0)
            maker.height.equalTo(40)
            maker.width.equalTo(50)
        }
        
        rightButton.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().inset(20)
            maker.centerY.equalTo(backButton)
            maker.height.equalTo(40)
            maker.width.greaterThanOrEqualTo(50)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(backButton)
            maker.centerX.equalToSuperview()
            maker.left.right.equalToSuperview().inset(60)
        }
    }
    
    @objc func onBack() {
        onBackClosure()
    }
    
    @objc func onRight() {
        onRightClosure()
    }
    
    func setRightItem(_ title: String) {
        rightButton.setTitle(title, for: .normal)
    }
    
    func setRightImage(_ image: UIImage?) {
        rightButton.setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
