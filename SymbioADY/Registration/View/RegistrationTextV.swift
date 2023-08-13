//
//  RegistrationTextV.swift
//  SymbioADY
//
//  Created by ady on 2023/8/11.
//

import UIKit
import RxSwift
import SnapKit

typealias TextVHeightBlock = (CGFloat,Bool) -> Void

class RegistrationTextV: UITextView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var textVHeightBlock: TextVHeightBlock?
    var mWidth:CGFloat = 0
    var maxHeight:CGFloat = 100
    weak var overrideNextResponder: UIResponder?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.tintColor = UIColor.ady.fieldColor
        self.returnKeyType = .send
        self.font = UIFont(.Ping_M, 16)
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.layer.cornerRadius = 16
        self.textContainer.lineFragmentPadding = 0
        
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func calculateHeight()-> CGFloat{
        let rect:CGRect =  self.text.boundingRect(with: CGSizeMake(UIScreen.main.bounds.width-150, self.maxHeight), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedString.Key.font:UIFont(.Ping_M, 16)], context: nil)
        return rect.size.height
    }
    
    override var next: UIResponder? {
        if overrideNextResponder == nil {
            return super.next
        } else {
            return overrideNextResponder
        }
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if overrideNextResponder != nil{
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

}

extension RegistrationTextV: UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        
        var textViewHeight = calculateHeight()
        if textViewHeight > maxHeight {
            textViewHeight = maxHeight
        }
        if textViewHeight <= 32 {
            textViewHeight = 32
        }
        var frame = textView.frame
        frame.size.height = textViewHeight
        textView.frame = frame
        textVHeightBlock?(textViewHeight,false)
        textView.isScrollEnabled = textViewHeight >= 32
        if let text1 = textView.text, text1.count > 300 {
            let index = text1.index(text1.startIndex, offsetBy: 300)
            textView.text = String(text1[text1.startIndex..<index])
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            if textView.text.isEmpty{
                return false
            }
            let suitText = textView.text.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
            if suitText.isEmpty{
                print("请输入内容！")
                return false
            }else{
                print("发送输入内容")
                textView.text = nil
                self.textViewDidChange(textView)
                return false
            }
        }
        //需要优化
        if textView.text == String.ady.SignUpInput{
            textView.text = ""
        }
        if let newText = textView.text, let newRange = Range(range, in: newText) {
            
            let result = (textView.text.count > 0) ? newText.replacingCharacters(in: newRange, with: text) : ""
            if result.count > 300{return false}
        }
        return true
    }
    //需要优化
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = String.ady.SignUpInput
        }
        textVHeightBlock?(0,true)
    }

    
}
