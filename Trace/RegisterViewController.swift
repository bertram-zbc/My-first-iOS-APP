//
//  RegisterViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTextFieldBound() //设置textfiled文字与边框距离
    }

    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var passWordAgain: UITextField!
    
    //注册按钮点击事件
    @IBAction func registerButtonClick(_ sender: UIButton) {
        self.view.makeToast("Register button clicked!!")
    }
    
    
    func setTextFieldBound(){
        
        //在textfield左边加入一个view的方式设置左边界距离
        let leftViewName = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        userName.leftView = leftViewName
        userName.leftViewMode = UITextFieldViewMode.always//模式为始终可见
        
        let leftViewPass = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        passWord.leftView = leftViewPass
        passWord.leftViewMode = UITextFieldViewMode.always
        
        let leftViewPassAgain = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        passWordAgain.leftView = leftViewPassAgain
        passWordAgain.leftViewMode = UITextFieldViewMode.always
    }
}
