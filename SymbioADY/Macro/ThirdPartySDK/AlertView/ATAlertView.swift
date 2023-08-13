//
//  ATAlertView.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit
class ATAlertView {
    class func showAlertView(title:String? = nil,message:String? = nil,normals:[String]? = nil,hights:[String]? = nil,completion: @escaping ((_ title:String,_ index :NSInteger) -> ())){
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let normals = normals {
            for (index,object) in normals.enumerated() {
                let action = UIAlertAction(title:object, style: .cancel) { (alert) in
                    completion(object,index)
                };
                alertView.addAction(action)
            }
        }
        if let hights = hights {
            for (index,sure) in hights.enumerated() {
                let action = UIAlertAction(title:(sure), style: .destructive) { (alert) in
                    completion(sure,index + (normals != nil ? normals!.count : 0))
                };
                alertView.addAction(action)
            }
        }
        let rootVC = global.getTopVc()
        rootVC?.present(alertView, animated:true, completion: nil)
    }
}

class ATActionSheet {
    class func showActionSheet(title:String? = nil,message:String? = nil,normals:[String]? = nil,hights:[String]? = nil,completion:@escaping ((_ title:String,_ index:NSInteger)->())){
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet);
        if let normals = normals {
            for (index, object) in normals.enumerated() {
                let action = UIAlertAction(title: (object), style:.default) { (alert) in
                    completion(object,index)
                }
                actionSheet.addAction(action)
            }
        }
        if let hights = hights {
            for (index, object) in hights.enumerated() {
                let action = UIAlertAction(title: (object ), style:.destructive) { (alert) in
                    completion(object,index + (normals != nil ? normals!.count : 0))
                }
                actionSheet.addAction(action)
            }
        }
        let rootVC = global.getTopVc()
        rootVC?.present(actionSheet, animated:true, completion: nil)
    }
}
extension UIAlertController{
    open override var supportedInterfaceOrientations :UIInterfaceOrientationMask{
        return .portrait
    }
    open override var shouldAutorotate: Bool{
        return false
    }
}
