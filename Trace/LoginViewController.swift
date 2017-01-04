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
        //print("loading login view...")

        rememberImage.image = UIImage(named: "check")//默认是记住密码的
        
        setTextFieldBound() //设置textfiled文字与边框距离
        
        //userName.text = "user1"
        //passWord.text = "123456"
    }
    
    //设置控件布局使适应各类尺寸屏幕
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //获取屏幕宽度
        let screenWidth = UIScreen.main.bounds.width
        //获取textfield宽度
        let textFieldWidth = userName.frame.width
        //计算label的横坐标，使之与textfield左对齐
        let xoff = screenWidth/2 - textFieldWidth/2
        layoutUsername.frame.origin.x = xoff
        layoutPassword.frame.origin.x = xoff
        
        //登录按钮宽度为97
        let xoff2 = screenWidth/2 - 97/2 + 5
        rememberImage.frame.origin.x = xoff2
        layoutRemember.frame.origin.x = xoff2+8+rememberImage.frame.width
    }

    var checkTag = true //标记是否选中
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var rememberImage: UIImageView!
    
    @IBOutlet var layoutUsername: UILabel!
    @IBOutlet var layoutPassword: UILabel!
    @IBOutlet var layoutRemember: UILabel!
//    func setStatus(){
//        let screenWidth = UIScreen.main.bounds.width
//        let textFieldWidth = userName.frame.width
//        print(textFieldWidth)
//        let xoff = screenWidth/2 - textFieldWidth/2
//        print(xoff)
//        layoutUsername.frame.origin.x = xoff
//        
//    }
    
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
        
        if userName.text == "" {
            self.view.makeToast("请输入用户名")
        }
        else if passWord.text == "" {
            self.view.makeToast("请输入密码")
        }else{
            //与服务器交互
            GetRequest()
        }
    }
    
    @IBAction func registerButtonClick(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController")
        viewController.transitioningDelegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    //同步Get方式发送请求，但是这个方法在iOS9中已经deprecated了
//    func GetRequest() -> String{
//        let urlString: String = String(format:"http://"+Config.ip+":"+Config.port+"/login?username=%@&password=%@", userName.text!,passWord.text!)
//        print(urlString)
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
//        
//    }
    
    
    //使用URLSession异步Get发送请求
    func GetRequest()  {
        
        //记录结果
        var result: String = "";
        
        //请求路径设置
        let urlString: String = String(format:"http://"+Config.ip+":"+Config.port+"/login?username=%@&password=%@", userName.text!,passWord.text!)
        let url: URL = URL(string: urlString)!
        //创建请求对象，对象内部已经包含请求头和方法（GET）
        let request: URLRequest = URLRequest(url: url)
        //获得会话对象
        let session: URLSession = URLSession.shared
        //根据会话对象创建一个task
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
        
        //设置执行延迟，因为需要等服务器返回数据，而服务器是异步的
        let time: TimeInterval = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+time, execute: {
            //已经得到服务器返回的数据
            if result != "" {
                if result == "network error" {
                    self.view.makeToast("网络错误，请检查网络设置")
                }
                else if result == "success" {
                    //self.view.makeToast("登录成功")
                    //跳转到MainPageViewController
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyBoard.instantiateViewController(withIdentifier: "MainPageViewController")
                    viewController.transitioningDelegate = self
                    self.present(viewController, animated: true, completion: nil)
                    
                    //异步文件操作，处理记住密码的文件配置
                    DispatchQueue.global().async {
                        if self.checkTag{
                            //标记选中表示需要记住密码
                            self.writeFile()
                        } else{
                            //TODO 判断配置文件是否存在，存在则删除
                        }
                        
                    }
                    
                }else{
                    self.view.makeToast("用户名或密码错误")
                }
            }
            //还没有得到返回的数据，可能是网络连接较慢，也可能是网络异常
            else{
                self.view.makeToast("网络连接较慢，请稍等", duration: 1, position: ToastPosition.bottom)
                sleep(1) //再等1秒，如果还是没有返回数据则认为是网络异常
                if result == ""{
                    self.view.makeToast("网络异常，请检查网络设置", duration: 2, position: ToastPosition.bottom)
                }
                else{
                    if result == "network error" {
                        self.view.makeToast("网络错误，请检查网络设置")
                    }
                    else if result == "success" {
                        //self.view.makeToast("登录成功")
                        //跳转到MainPageViewController
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyBoard.instantiateViewController(withIdentifier: "MainPageViewController")
                        viewController.transitioningDelegate = self
                        self.present(viewController, animated: true, completion: nil)
                        
                        DispatchQueue.global().async {
                            if self.checkTag{
                                //标记选中表示需要记住密码
                                self.writeFile()
                            } else{
                                //TODO 判断配置文件是否存在，存在则删除
                            }
                            
                        }
                        
                    }else{
                        self.view.makeToast("用户名或密码错误")
                    }
                }
            }
            
        })
       
    }
    
    func writeFile(){
        print("write file")
        //文件操作
        let fileManager = FileManager.default
        let mydir = cachePath + "/Trace/Config"
//        print(mydir)
//        print(homeDirectory)
//        print(tmpDirectory)
        do {
            //创建路径
            try fileManager.createDirectory(atPath: mydir, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("error create dir")
        }
        
        let filePath = mydir + "/login.txt"
        print(filePath)
        let isExist = fileManager.fileExists(atPath: filePath)
        if isExist{
            
            //print("文件已存在")
            
            //读文件的操作
//            do {
//                let data = try NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue)
//                print(data)
//            } catch {
//                print("error read file")
//            }
            
            //文件存在则直接删除重新创建
            do {
                try fileManager.removeItem(atPath: filePath)
            } catch {
                print("delete file error")
            }
            
        }
        
        //创建文件并写入用户名
        let info = userName.text
        do {
            try info!.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("error write file")
        }
        
        
        
    }

    //触摸关闭键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

//设置转场动画代理
extension LoginViewController: UIViewControllerTransitioningDelegate{
    
    //present动画效果
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
    //dismiss动画效果
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation()
    }
}
