//
//  LoginViewController.swift
//  Trace
//
//  Created by Bertram on 2016/12/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading login view...")

        setTextFieldBound() //设置textfiled文字与边框距离
    }

    var checkTag = false //标记是否选中
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var rememberImage: UIImageView!
    
    func setTextFieldBound(){
        
        //在textfield左边加入一个view的方式设置左边界距离
        let leftViewName = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        userName.leftView = leftViewName
        userName.leftViewMode = UITextFieldViewMode.always//模式为始终可见
        
        let leftViewPass = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        passWord.leftView = leftViewPass
        passWord.leftViewMode = UITextFieldViewMode.always
    }

    //是否记住密码
    @IBAction func isCheck(_ sender: UITapGestureRecognizer) {
        print("check button clicked!")
        if checkTag {
            //已经选中，改为没选中
            rememberImage.image = UIImage(named: "uncheck")
            checkTag = false
        }else{
            rememberImage.image = UIImage(named: "check")
            checkTag = true
        }
    }
    
    //登录按钮点击
    @IBAction func loginButtonClick(_ sender: UIButton) {
        
    }
    
    //同步Get方式发送请求
    func GetRequest(){
        let urlString: String = String(format:"http://192.168.253.1:8888/login?username=%@&password=%@", userName.text!,passWord.text!)
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
        
        do {
            let recieveData = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            let dataString = NSString.init(data: recieveData, encoding: String.Encoding.utf8.rawValue)//得到服务器返回数据
            print(response ?? "none") //response默认值为none
            print(dataString!)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
}
