//
//  RegistrationTableViewCell.swift
//  SymbioADY
//
//  Created by ady on 2023/8/12.
//

import UIKit
import RxSwift




class RegistrationAvatarTableViewCell: RegistrationTableViewCell {
    
    let click = UITapGestureRecognizer()
    
    let avatarbgV = UIView().then{
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.backgroundColor = UIColor.ady.background3
    }
    
    //头像
    let avatarImageV = UIImageView().then{
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.blue.cgColor
        $0.backgroundColor = UIColor.ady.avatarColor
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFill
    }
    
    override func addSubviews(){
        contentView.addSubview(avatarbgV)
        contentView.addSubview(avatarImageV)
        avatarImageV.addGestureRecognizer(click)
        
        avatarbgV.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(bgV).inset(10)
            make.height.equalTo(bgV).inset(10)
            make.width.height.equalTo(70)
        }
        avatarImageV.snp.makeConstraints { make in
            make.center.equalTo(avatarbgV)
            make.height.width.equalTo(50)
        }
        
        click.rx.event.asObservable().subscribe(onNext: {[weak self] (_) in
            guard self != nil else { return }
            ATPickerPhoto.pickerPhoto { (image) in
                self?.avatarImageV.image = image
            }
        }).disposed(by: cellDisposeBag)
    }
        
    override func configure(with item:RegistrationItem){
        tlb.text = item.RTitle
        avatarbgV.backgroundColor = item.RColor
    }

}

class RegistrationInputTableViewCell: RegistrationTableViewCell {
    
    let textV = RegistrationTextV().then{
        $0.textColor = UIColor.ady.fieldColor
        $0.font = UIFont(.Ping_R, 14)
        $0.textAlignment = .right
    }
    
    override func addSubviews(){
        contentView.addSubview(textV)
        
        textV.snp.makeConstraints { (make) in
            make.top.equalTo(tlb.snp_topMargin).offset(2)
            make.right.equalTo(bgV).inset(10)
            make.left.equalTo(tlb.snp.right).offset(2)
            make.height.equalTo(30)
            make.bottom.equalTo(bgV.snp.bottom).inset(5)
        }
    }
        
    override func configure(with item:RegistrationItem){
        tlb.text = item.RTitle
        textV.text = item.RInput
        if item.RHeight != 0{
            textV.snp.updateConstraints({ make in
                make.height.equalTo(item.RHeight)
            })
        }
    }

}

class RegistrationSelTableViewCell: RegistrationTableViewCell {
    
    let sellb = UILabel().then{
        $0.textColor = UIColor.ady.titleColor
        $0.font = UIFont(.Ping_R, 14)
        $0.textAlignment = .right
    }
    
    override func addSubviews(){
        contentView.addSubview(sellb)
        
        sellb.snp.makeConstraints { (make) in
            make.right.equalTo(bgV).inset(10)
            make.left.equalTo(tlb.snp.right).offset(2)
            make.height.equalTo(30)
            make.centerY.equalTo(bgV)
            make.bottom.equalTo(bgV.snp.bottom).inset(15)
        }
    }
        
    override func configure(with item:RegistrationItem){
        tlb.text = item.RTitle
        sellb.text = item.RInput
    }

}


class RegistrationTableViewCell: AdyUITableViewCell {
        
    let bgV = UIView().then{
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.backgroundColor = .white
    }
    
    let tlb = UILabel().then{
        $0.textColor = UIColor.ady.titleColor
        $0.font = UIFont(.Ping_R, 16)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.ady.background2
        
        contentView.addSubview(bgV)
        contentView.addSubview(tlb)
        
        bgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(16)
            make.right.equalTo(contentView).inset(16)
            make.height.equalTo(contentView).inset(10)
        }
        tlb.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgV)
            make.left.equalTo(bgV).inset(5)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(30)
        }
        
        addSubviews()
    }
    
    func addSubviews(){
        
    }
    func configure(with item:RegistrationItem){
        tlb.text = item.RTitle
        tlb.snp.remakeConstraints {(make) in
            make.center.equalTo(bgV)
            make.height.equalTo(30)
            make.bottom.equalTo(bgV.snp.bottom).inset(10)
        }
        tlb.textAlignment = .center
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class AdyUITableViewCell: UITableViewCell {
    
    var cellDisposeBag = DisposeBag()
    //准备复用
    override func prepareForReuse() {
        super.prepareForReuse()
        cellDisposeBag = DisposeBag()
    }
}
