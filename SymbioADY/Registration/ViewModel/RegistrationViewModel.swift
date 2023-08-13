//
//  RegistrationViewModel.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit
import RxRelay

class RegistrationViewModel {
    
    var mainModels = [
        RegistrationItem(RTitle: String.ady.SignUpList1 ,RInput: "", RColor: .clear, RStatus: .RAvatarStatus,RHeight: 0),
        RegistrationItem(RTitle: String.ady.SignUpList2 ,RInput: String.ady.SignUpInput, RColor: .clear, RStatus: .RInputStatus,RHeight: 0),
        RegistrationItem(RTitle: String.ady.SignUpList3 ,RInput: String.ady.SignUpInput, RColor: .clear, RStatus: .RInputStatus,RHeight: 0),
        RegistrationItem(RTitle: String.ady.SignUpList4 ,RInput: String.ady.SignUpInput, RColor: .clear, RStatus: .RInputStatus,RHeight: 0),
        RegistrationItem(RTitle: String.ady.SignUpList5 ,RInput: String.ady.SignUpInput, RColor: .clear, RStatus: .RInputStatus,RHeight: 0),
        RegistrationItem(RTitle: String.ady.SignUpList6 ,RInput: String.ady.SignUpSel, RColor: .clear, RStatus: .RSelStatus,RHeight: 0),
        RegistrationItem(RTitle: String.ady.SignUpBtn ,RInput: "", RColor: .clear, RStatus: .RClilkStatus,RHeight: 0)]
    
    
    /**First Name*/
    var firstName = BehaviorRelay<String>(value: "")
    
    
    //名字判断
    func isName(name : String) -> Bool{
        if name == String.ady.SignUpInput{
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^([\\u4e00-\\u9fa5]{1,20}|[a-zA-Z\\.\\s]{1,20})$")
        let isValid = predicate.evaluate(with: name)
        return isValid as Bool
    }
    
    //手机号判断
    func isTelNumber(num:String)->Bool{

        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"

        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";

        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";

        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";

        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)

        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )

        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)

        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)

        if ((regextestmobile.evaluate(with: num) == true)
            
            || (regextestcm.evaluate(with: num)  == true)
            
            || (regextestct.evaluate(with: num) == true)
            
            || (regextestcu.evaluate(with: num) == true))
            {return true}else{return false}
        
    }
    
    
    //邮箱判断
    func isEmail(email : String) -> Bool{
        let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        let isValid = predicate.evaluate(with: email)
        return isValid as Bool
    }
}

