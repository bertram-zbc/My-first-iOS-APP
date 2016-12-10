//
//  LoginViewController.swift
//  Trace
//
//  Created by Apple on 2016/12/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTextFieldBound() //设置textfiled文字与边框距离
    }

    var checkTag = false //标记是否选中
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var rememberImage: UIImageView!
    
    func setTextFieldBound(){
        
        //在textfield左边加入一个view的方式设置左边界距离
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        userName.leftView = leftView
        userName.leftViewMode = UITextFieldViewMode.always//模式为始终可见
        
        passWord.leftView = leftView
        passWord.leftViewMode = UITextFieldViewMode.always
        
    }

    @IBAction func isCheck(_ sender: UITapGestureRecognizer) {
        if checkTag {
            //已经选中，改为没选中
            rememberImage.image = UIImage(named: "uncheck")
            checkTag = false
        }else{
            rememberImage.image = UIImage(named: "check")
            checkTag = true
        }
    }
}
