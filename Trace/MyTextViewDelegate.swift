//
//  MyTextViewDelegate.swift
//  Trace
//
//  Created by Bertram on 2016/12/15.
//  Copyright © 2016年 Bertram. All rights reserved.
//

import UIKit

/*
 *用于处理Textview与keyboard之间的一些关系
 *比如监听keyboard弹出事件与消失
 *处理keyboard覆盖textview的情况
 */
class TextViewKeyBoard: NSObject {
    
    weak fileprivate var pv: UIView!
    weak fileprivate var textView: UITextView!
    lazy fileprivate var av = {AccessoryView.instance()}()
    fileprivate var offsetY: CGFloat!  //偏移修正使得可以手动调整
    fileprivate var willShow = false
    
//    var textViewWillBeginEditlosure: ((_ textView: UITextView)->Void)!
//    var textViewDidEndEditClosure: ((_ textView: UITextView)->Void)!
//    var textViewDidChangeClosure: ((_ textView: UITextView)->Void)!
//    var msg: String!{
//        didSet{
//            av.msgLabel.text = msg
//        }
//    }
    
    //移除监控
    deinit{NotificationCenter.default.removeObserver(self)}
}

extension TextViewKeyBoard: UITextViewDelegate{
    
    //屏幕高度
    var ScreenH: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    func avoid(inView v: UIView!, textView: UITextView, offSetY: CGFloat) {
        pv = v
        self.textView = textView
        self.offsetY = offSetY
        textView.delegate = self
        //为TextView添加accessoryView，便于在编辑textview时关闭键盘
        if textView.inputAccessoryView == nil {
            textView.inputAccessoryView = av
            av.doneBtnActionClosure = { //实现点击按钮事件
                textView.endEditing(true) //关闭键盘
            }
        }
        //监听弹出键盘
        NotificationCenter.default.addObserver(self, selector: #selector(TextViewKeyBoard.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        //监听关闭键盘
        NotificationCenter.default.addObserver(self, selector: #selector(TextViewKeyBoard.keyboardDidHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //弹出键盘时textview向上移动
    func keyboardWillShow(_ noti: Notification) {
        if !willShow{
            return
        }
        
        let info = noti.userInfo as! [String:AnyObject]
        //获取键盘高度
        let kbH = info[UIKeyboardFrameEndUserInfoKey]!.cgRectValue.height
        let textViewRect = textView.convert(textView.bounds, to: nil)
        let maxH = ScreenH - kbH
        let moveUP = textViewRect.maxY - maxH //计算出需要上移的距离
        //加上offset修正的真正上移距离
        let transformH = -(moveUP+self.offsetY)
        //上移动画
        UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.pv.transform = CGAffineTransform(translationX: 0, y: transformH)
        })
    }
    
    //关闭键盘时向下移回原来位置
    func keyboardDidHide(_ noti: Notification) {
        UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.pv.transform = CGAffineTransform.identity
        })
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        //TODO 需要添加一些修改：判断什么时候willShow为true
        //willShow = true //为true表示随着移动
        if calculateLine(str: textView.text){
            willShow = true
        } else{
            willShow = false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //print("2")
        willShow = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //响应textview进行编辑
        if calculateLine(str: textView.text) {
            //当发现光标已经被键盘阻挡则向上移动textview
            UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                self.pv.transform = CGAffineTransform(translationX: 0, y: -Config.keyboardHight-44)
            })
        }else{
            //当不被阻挡则移回原来位置
            UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                self.pv.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    
    //计算文本是否在键盘之下
    func calculateLine(str:String) -> Bool{
        
        let lineWidth = Int(self.textView.frame.width)
        var line: Int = 0 //记录行数
        let strArray = str.components(separatedBy: "\n")
        for i in 0..<strArray.count{
            let bytes = strArray[i].lengthOfBytes(using: String.Encoding.utf8)
            let wordCount:Int = bytes/3 //大致计算汉字个数，一个汉字3字节
            let allWidth = wordCount*20 //计算总的长度，一个字20像素
            line = line + Int(allWidth/lineWidth) + 1
        }
        
        line += 1 //调整偏差
        //计算textview光标的大致位置
        let offY = CGFloat(50 + line * 30)
        //print(offY)
        //print(ScreenH - Config.keyboardHight)
        //44是键盘上面的view的高度
        if offY > (ScreenH - Config.keyboardHight - 44) {
            //在键盘的位置下面，返回true
            return true
        } else{
            return false
        }
    }
        
}
