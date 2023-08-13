//
//  ATPickerPhoto.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit
import AVFoundation
import Photos

class ATPickerPhoto: NSObject {
    private static let manager = ATPickerPhoto()
    private var completion :((_ image :UIImage?) -> ())? = nil
    private var completions :((_ listData :[UIImage]) -> ())? = nil
    public static func pickerPhoto(completion :@escaping ((_ image : UIImage?) -> ())){
        ATActionSheet.showActionSheet(title:"请选择",normals: ["拍照","相册选择"], hights:["取消"]) { (title , index) in
            if index == 0{
                pickerPhoto(sourceType: .camera, completion: completion)
            }else if index == 1{
                pickerPhoto(sourceType: .photoLibrary, completion: completion)
            }
        }
    }
    public static func pickerPhoto(sourceType :UIImagePickerController.SourceType,
                                   completion :@escaping ((_ image : UIImage?) -> ())){
        let auth = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if auth == .denied {
            ATAlertView.showAlertView(title:"App相机权限受限", message: "请在设置中允许访问相机", normals:["取消"], hights: ["确定"]) { (title , index) in
                if index == 0{
                    return
                }
                let share = UIApplication.shared
                if let url = URL.init(string:UIApplication.openSettingsURLString){
                    if share.canOpenURL(url){
                        share.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            return
        }
        ATPickerPhoto.manager.completion = completion
        let vc = global.getTopVc()
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = ATPickerPhoto.manager
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        vc?.present(picker, animated: true, completion: nil)
    }
}
extension ATPickerPhoto : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        global.getTopVc()?.dismiss(animated: true, completion: nil)
        guard let comple = ATPickerPhoto.manager.completion else { return }
        comple(nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        global.getTopVc()?.dismiss(animated: true, completion: nil)
        guard let comple = ATPickerPhoto.manager.completion else { return }
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            comple(image)
        }else{
            comple(nil)
        }
    }
}
