//
//  ViewController.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit

class ViewController: NavC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.barTitle = String.ady.signUp
        self.navBar.backButton.isHidden = true
        adyLayoutSubViews()
    }

    func adyLayoutSubViews() {
        
        let btn = global.get_Button(view, String.ady.signUp).then{
            $0.addTarget(self, action: #selector(signUpClilk), for: .touchUpInside)
        }

        btn.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.left.right.equalTo(self.view).inset(10)
            make.height.equalTo(48)
        }
    }
    
    @objc func signUpClilk(){
        self.push(RegistrationDefaultVc())
//        self.push(RegistrationVc())
    }
}

