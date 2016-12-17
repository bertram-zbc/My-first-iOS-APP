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
        if userName.text == "" {
            self.view.makeToast("请输入用户名")
        }
        else if passWord.text == "" || passWordAgain.text == "" {
            self.view.makeToast("请输入密码")
        }
        else if passWordAgain.text != passWord.text {
            self.view.makeToast("密码不一致，请重新输入")
        }else {
            //发送数据给服务器并接收返回的结果
            let result = GetRequest()
            if result == "network error" {
                self.view.makeToast("网络错误，请检查网络设置")
            }
            else if result == "username exist" {
                self.view.makeToast("用户名已存在")
            }
            else if result == "server error" {
                self.view.makeToast("服务器异常，请稍后重试")
            }
            else{
                self.view.makeToast("注册成功")
            }
        }
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
    
    func GetRequest()->String{
        let urlString: String = String(format:"http://"+Config.ip+":"+Config.port+"/register?username=%@&password=%@", userName.text!,passWord.text!)
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do {
            let recieveData = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            let dataString = NSString.init(data: recieveData, encoding: String.Encoding.utf8.rawValue)//得到服务器返回数据
            print(response ?? "none") //response默认值为none
            print(dataString!)
            return dataString as! String
        } catch let error as NSError {
            print(error.localizedDescription)
            return "network error"
        }

    }
}
