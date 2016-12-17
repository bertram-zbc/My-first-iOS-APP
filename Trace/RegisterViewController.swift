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
            GetRequest()
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
    
//    func GetRequest()->String{
//        let urlString: String = String(format:"http://"+Config.ip+":"+Config.port+"/register?username=%@&password=%@", userName.text!,passWord.text!)
//        let url = URL(string: urlString)
//        let request = URLRequest(url: url!)
//        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
//        
//        do {
//            let recieveData = try NSURLConnection.sendSynchronousRequest(request, returning: response)
//            let dataString = NSString.init(data: recieveData, encoding: String.Encoding.utf8.rawValue)//得到服务器返回数据
//            print(response ?? "none") //response默认值为none
//            print(dataString!)
//            return dataString as! String
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return "network error"
//        }
//    }
    
    //具体逻辑与登录界面相同，详细解释见LoginViewController
    func GetRequest() {
        
        var result: String = "";
        let urlString: String = String(format:"http://"+Config.ip+":"+Config.port+"/register?username=%@&password=%@", userName.text!,passWord.text!)
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session: URLSession = URLSession.shared
        let dataTask: URLSessionDataTask = session.dataTask(with: request){ (data,response,error) in
            if error == nil { //连接成功
                //得到服务器返回数据
                let dataString = NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)
                result = dataString as! String
            }
            else{ //连接失败
                result = "network error"
            }
        }
        dataTask.resume() //执行任务
        
        let time: TimeInterval = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+time, execute: {
            //已经得到服务器返回的数据
            if result != "" {
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
            //还没有得到返回的数据，可能是网络连接较慢，也可能是网络异常
            else{
                self.view.makeToast("网络连接较慢，请稍等", duration: 1, position: ToastPosition.bottom)
                sleep(1) //再等1秒，如果还是没有返回数据则认为是网络异常
                if result == "" {
                    self.view.makeToast("网络异常，请检查网络设置", duration: 2, position: ToastPosition.bottom)
                }
                else {
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
     
        })
    }
    

    
    
}
