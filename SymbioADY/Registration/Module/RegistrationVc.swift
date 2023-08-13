//
//  RegistrationVc.swift
//  SymbioADY
//
//  Created by ady on 2023/8/9.
//

import UIKit
import SwiftyUserDefaults
import FHDiffableViewControllers
import RxSwift
import Chrysan

class RegistrationDefaultVc:NavC {
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = RegistrationVc()
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            controller.view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            controller.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        controller.view.setNeedsLayout()
        controller.view.layoutIfNeeded()
        self.addChild(controller)
        
        self.barTitle = String.ady.registration
    }
}
class RegistrationVc: FHDiffableTableViewController<RegistrationSection, RegistrationItem> {
    
    let viewModel = RegistrationViewModel()
    
    override var cellProvider: UITableViewDiffableDataSource<RegistrationSection, RegistrationItem>.CellProvider {
        return { [self] tableView, indexPath, item in
       

            if item.RStatus == .RAvatarStatus{
                let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationAvatarTableViewCell.identifier, for: indexPath) as! RegistrationAvatarTableViewCell?
                cell?.configure(with: item)
                return cell
            }
            if item.RStatus == .RInputStatus{
                let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationInputTableViewCell.identifier, for: indexPath) as! RegistrationInputTableViewCell?
                cell?.configure(with: item)
                cell?.textV.textVHeightBlock = {  [weak self] height,isReload in
                    guard let `self` = self else { return }
                    if isReload{
                        applySnapshot()
                    }else{
                        var selItem  = self.viewModel.mainModels[indexPath.row]
                        selItem.RHeight = height
                        selItem.RInput = cell?.textV.text ?? String.ady.SignUpInput
                        self.viewModel.mainModels.remove(at: indexPath.row)
                        self.viewModel.mainModels.insert(selItem, at: indexPath.row)
                    }
                }
                                                     
                return cell
            }
            if item.RStatus == .RSelStatus{
                let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationSelTableViewCell.identifier, for: indexPath) as! RegistrationSelTableViewCell?
                cell?.configure(with: item)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: RegistrationTableViewCell.identifier, for: indexPath) as! RegistrationTableViewCell?
            cell?.configure(with: item)
            return cell
        }
    }
    

    
    lazy var customDataSource = CustomDataSource(tableView: tableView, cellProvider: cellProvider)
    override var dataSource: UITableViewDiffableDataSource<RegistrationSection, RegistrationItem> {
        return customDataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adyLayoutSubViews()
        adyAddObserver()
        applySnapshot()

    }
    
    func applySnapshot() {
        var snapshot = FHSnapshot()
        snapshot.appendSections([.RMain,.RClilk])
        for index in 0...viewModel.mainModels.count-1 {
            snapshot.appendItems([viewModel.mainModels[index]],toSection:.RMain)
        }
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    func adyLayoutSubViews() {
        tableView.backgroundColor = UIColor.ady.background2
        
        tableView.register(RegistrationTableViewCell.self, forCellReuseIdentifier: RegistrationTableViewCell.identifier)
        tableView.register(RegistrationSelTableViewCell.self, forCellReuseIdentifier: RegistrationSelTableViewCell.identifier)
        tableView.register(RegistrationInputTableViewCell.self, forCellReuseIdentifier: RegistrationInputTableViewCell.identifier)
        tableView.register(RegistrationAvatarTableViewCell.self, forCellReuseIdentifier: RegistrationAvatarTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
    }
       
    func adyAddObserver() {
//        let textV = RegistrationTextV().viewWithTag(1)
//        _ = textV.rx.textInput <-> viewModel.firstName
    }

    @objc func signUpClilk(){
        let firstName = viewModel.mainModels[1].RInput
        if !viewModel.isName(name: firstName) {
            chrysan.show(.error, message:"请输入正确的名字", hideDelay: 1)
            return
        }
        
        let lastName = viewModel.mainModels[2].RInput
        if !viewModel.isName(name: lastName) {
            chrysan.show(.error, message:"请输入正确的姓", hideDelay: 1)
            return
        }
        
        let phoneNumber = viewModel.mainModels[3].RInput
        if !viewModel.isTelNumber(num: phoneNumber) {
            chrysan.show(.error, message:"请输入正确的手机号", hideDelay: 1)
            return
        }
        
        let email = viewModel.mainModels[4].RInput
        if !viewModel.isEmail(email: email) {
            chrysan.show(.error, message:"请输入正确的邮箱", hideDelay: 1)
            return
        }
        //正常需要在ViewModel写请求接口，及回调
        show_Alert(String.ady.isSignUp).done { _ in
            Defaults[\.isLogin] = LoginEnum.login_Up.rawValue
            NotificationCenter.default.post(name: NSNotification.Name.updateWindow, object: nil)
        }.catch { _ in}
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
        /*do your actions with the selected item*/
        if item?.RStatus == .RSelStatus{
            let vc = ColorSelectC()
            vc.colorSelectBlock = {  [weak self] color in
                guard let `self` = self else { return }
                var selItem  = self.viewModel.mainModels[0]
                selItem.RColor = color
                self.viewModel.mainModels.remove(at: 0)
                self.viewModel.mainModels.insert(selItem, at: 0)
                applySnapshot()
            }
            self.push(vc)
        }
        
        if item?.RStatus == .RClilkStatus{
            signUpClilk()
        }


        
    }
    
}

class CustomDataSource: UITableViewDiffableDataSource<RegistrationSection, RegistrationItem> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch snapshot().sectionIdentifiers[section] {
        case .RMain:
            return ""
        case .RClilk:
            return ""
        }
    }
}


