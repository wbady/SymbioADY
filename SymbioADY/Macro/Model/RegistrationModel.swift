//
//  RegistrationModel.swift
//  SymbioADY
//
//  Created by ady on 2023/8/12.
//

import HandyJSON


///注册界面使用
struct RegistrationItem: Hashable {
    var RTitle: String
    var RInput: String
    var RColor: UIColor //颜色
    var RStatus: RegistrationStatus//类型
    var RHeight: CGFloat
}

///注册界面使用
enum RegistrationStatus {
    case RAvatarStatus, RInputStatus,RSelStatus,RClilkStatus
}

///注册界面使用
enum RegistrationSection: CaseIterable {
    case RMain,RClilk
}

/**注册*/
class RegistrationModel: NSObject,HandyJSON {
    /**头像*/
    @objc var iconUrl = ""
    /**输入内容*/
    @objc var input = ""

    /**高度计算*/
    @objc var rowHeight:CGFloat {
        var height:CGFloat = 60
        if !iconUrl.isEmpty {
            height += 30
        }
        if !input.isEmpty {
            let str = NSAttributedString(string: input, attributes: [
                .font: UIFont(.Ping_R, 13)
            ])
            height += str.boundingRect(with: CGSize(width: screenWidth-50, height: 0),
                                       options: [
                                        NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading
                                       ],
                                       context: nil).height
        }
        return height
    }
    @objc var id = ""
    required override init() {}
}
